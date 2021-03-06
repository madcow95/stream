package com.moviestream.movie.board;

import java.io.File;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.moviestream.movie.board.domain.AttachFileDTO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnails;

@Controller
@Log4j
@RequestMapping("upload")
public class UploadController {
	
	private String uploadPath = "C:\\Users\\choi\\Desktop\\realmovie\\movie\\src\\main\\webapp\\resources\\fileUpload";
	
	@GetMapping("/uploadForm")
	public void uploadForm() {
		log.info("upload Form");
	}
	
	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile, Model model) throws Exception {
		for (MultipartFile multipartFile : uploadFile) {
			log.info("---------------------------------------------------");
			log.info("Upload File Name : " + multipartFile.getName());
			log.info("Upload File Size : " + multipartFile.getSize());
			log.info("Upload File ContentType : " + multipartFile.getContentType());
		}
	}
	
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		java.util.Date date = new java.util.Date();
		String str = sdf.format(date);
		log.info("str =============== "+str);
		return str.replace("-", File.separator);
	}
	
	private boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	@PostMapping(value = "/uploadAjaxAction", 
			 produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
@ResponseBody
public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
	log.info("update ajax post ...........................");
	List<AttachFileDTO> attachList = new ArrayList<>();
	
	String uploadFolderPath = getFolder();
	
	File uploadFolder = new File(uploadPath, getFolder());
	log.info("uploadFolder path >>>> " + uploadFolder);
	
	if(uploadFolder.exists() == false) {
		uploadFolder.mkdirs();
	}
	for(MultipartFile multipartFile : uploadFile) {
		log.info("---------------------------------------------------");
		log.info("Upload File Name : " + multipartFile.getName());
		log.info("Upload File Size : " + multipartFile.getSize());
		log.info("Upload File ContentType : " + multipartFile.getContentType());
		
		AttachFileDTO attachFileDTO = new AttachFileDTO();
		String uploadFileName = multipartFile.getOriginalFilename();
		
		uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
		log.info("only file name : " + uploadFileName);
		
		attachFileDTO.setFileName(uploadFileName);
		
		UUID uuid = UUID.randomUUID();
		uploadFileName = uuid.toString() + "_" + uploadFileName;
		
		try {
			File saveFile = new File(uploadFolder, uploadFileName);
			multipartFile.transferTo(saveFile);
			
			attachFileDTO.setUuid(uuid.toString());
			attachFileDTO.setUploadPath(uploadFolderPath);
			
			if(checkImageType(saveFile)) {
				attachFileDTO.setImage(true);
				
				File thumbnail = new File(uploadFolder, "s_" + uploadFileName);
				Thumbnails.of(saveFile).size(100, 100).toFile(thumbnail);
			}
			
			attachList.add(attachFileDTO);
		} catch (Exception e) {
			log.error(e.getMessage());
		}
	}
	return new ResponseEntity<>(attachList, org.springframework.http.HttpStatus.OK);
}
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName) {
		log.info("fileName >>> "+fileName);
		
		File file = new File(uploadPath + "\\" + fileName);
		log.info("file >>> "+file);
		
		ResponseEntity<byte[]> result = null;
		try {
			HttpHeaders header = new HttpHeaders();
			
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, org.springframework.http.HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@GetMapping(value = "/download",
			produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName) {
		Resource resource = new FileSystemResource(uploadPath + "\\" + fileName);
		
		if(resource.exists() == false) {
			return new ResponseEntity<>(org.springframework.http.HttpStatus.NOT_FOUND);
		}
		String resourceName = resource.getFilename();
		
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_") + 1);
		
		HttpHeaders headers = new HttpHeaders();
		try {
			boolean checkIE = (userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1);
			
			String downloadName = null;
			
			if(checkIE) {
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF8").replaceAll("\\+", " ");
			} else {
				downloadName = new String(resourceOriginalName.getBytes("UTF-8"), "ISO-8859-1");
			}
			
			headers.add("Content-Disposition", "attachment; filename="+downloadName);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ResponseEntity<>(resource, headers, org.springframework.http.HttpStatus.OK);
	}
	
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type) {
		log.info("deleteFile >>> "+fileName);
		
		File file;
		
		try {
			file = new File(uploadPath + "\\" + URLDecoder.decode(fileName, "UTF-8"));
			
			file.delete();
			
			if(type.equals("image")) {
				String largeFileName = file.getAbsolutePath().replace("\\s_", "\\");
				
				log.info("largeFileName ========== "+largeFileName);
				
				file = new File(largeFileName);
				file.delete();
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(org.springframework.http.HttpStatus.NOT_FOUND);
		}
		
		return new ResponseEntity<>("deleted" ,org.springframework.http.HttpStatus.OK);
	}

}

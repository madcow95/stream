package com.moviestream.movie.board.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.moviestream.movie.board.domain.BoardAttachDTO;
import com.moviestream.movie.board.mapper.BoardAttachMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Component
@Log4j
public class FileCheckTask {
	
	@Setter(onMethod_ = {@Autowired})
	private BoardAttachMapper mapper;
	
	
	private String getFolderYesterday() throws Exception {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Calendar cal = Calendar.getInstance();
		
		cal.add(Calendar.DATE, 0);
		
		String str = sdf.format(cal.getTime());
		
		return str.replace("-", File.separator);
	}
	
	@Scheduled(cron = "* * 0 * * *")
	public void checkFiles() throws Exception {
		log.warn("File check task running >>>>>>>>>>>>>>>>>>>>>>.");
		log.warn("=================================================");
		log.warn("new date >>>>>>>>> " + new Date());
		
		// 2일 전에 db에 저장된 파일들
		List<BoardAttachDTO> fileList = mapper.getOldFiles();
		
		// 의 경로
		List<Path> fileListPaths = fileList.stream()
										   .filter(vo -> vo.isFiletype() == true)
										   .map(vo -> Paths.get("C:\\Users\\choi\\Desktop\\realmovie\\movie\\src\\main\\webapp\\resources\\fileUpload", vo.getUploadPath(), vo.getUuid() + "_" + vo.getFileName()))
										   .collect(Collectors.toList());
		
		// 의 썸네일 이미지
		fileList.stream().filter(vo -> vo.isFiletype() == true)
						 .map(vo -> Paths.get("C:\\Users\\choi\\Desktop\\realmovie\\movie\\src\\main\\webapp\\resources\\fileUpload", vo.getUploadPath(), "s_" + vo.getUuid() + "_" + vo.getFileName()))
						 .forEach(p -> fileListPaths.add(p));
		log.warn("=================================================");
		
		fileListPaths.forEach(p -> log.warn(p));
		
		File targetDir = Paths.get("C:\\Users\\choi\\Desktop\\realmovie\\movie\\src\\main\\webapp\\resources\\fileUpload", getFolderYesterday())
							  .toFile();
		
		File[] removeFiles = targetDir.listFiles(file -> fileListPaths.contains(file.toPath()) == false);
		log.warn("=================================================");
		for(File file : removeFiles) {
			log.warn(file.getAbsolutePath());
			file.delete();
		}
	}

}

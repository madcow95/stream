package com.moviestream.movie;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.UrlPathHelper;

import com.google.api.client.googleapis.json.GoogleJsonResponseException;
import com.google.api.client.http.HttpRequest;
import com.google.api.client.http.HttpRequestInitializer;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.services.youtube.YouTube;
import com.google.api.services.youtube.YouTube.Search;
import com.google.api.services.youtube.model.SearchListResponse;
import com.google.api.services.youtube.model.SearchResult;
import com.moviestream.movie.board.domain.MovieInfoDTO;
import com.moviestream.movie.member.domain.MemberDTO;
import com.moviestream.movie.member.service.IMemberService;
import com.moviestream.movie.movie.mapper.MovieMapper;
import com.moviestream.movie.movie.service.IMovieService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	private static String PROPERTIES_FILENAME = "youtube.properties";
	
	private static final HttpTransport HTTP_TRANSPORT = new NetHttpTransport();
	
	private static final JsonFactory JSON_FACTORY = new JacksonFactory();
	
	private static final long NUMBER_OF_VIDEOS_RETURNED = 3;
	
	private static YouTube youtube;
	
	@Autowired
	private IMovieService service;
	
	@Autowired
	private IMemberService memberService;
	
	@Autowired
	private MovieMapper mapper;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpServletRequest request, HttpSession session) throws Exception{
//		request.get
		logger.info("Welcome home! The client locale is {}.", locale);
		List<MovieInfoDTO> movieList = mapper.getMovie();
		model.addAttribute("movieList", movieList);
		return "index";
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) throws Exception {
		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping("/test")
	public void test() throws Exception{
	}
	@RequestMapping("/map")
	public void map() throws Exception{
	}
	@RequestMapping("/kakaomap")
	public void moira() throws Exception{
	}
	@RequestMapping("/test2")
	public void test2() throws Exception{
	}
	@RequestMapping("/test3")
	public void test3() throws Exception{
	}
	@RequestMapping("/test4")
	public void test4() throws Exception{
	}
	@RequestMapping("/kakaologin")
	public void kakaologin() throws Exception{
	}
	@PostMapping("/record")
	public void record() throws Exception {
		
	}
	
	@PostMapping("/kakaojoin")
	public String kakaojoin(@RequestParam("kakaoName") String name,
						  @RequestParam("kakaoEmail") String email,
						  @RequestParam("kakaoGender") String gender,
						  @RequestParam("kakaoImage") String image,
						  @RequestParam("loginCategory") String category,
						  Model model) throws Exception{
		Map<String, String> kakaoMap = new HashMap<>();
		kakaoMap.put("name", name);
		kakaoMap.put("email", email);
		kakaoMap.put("gender", gender);
		kakaoMap.put("image", image);
		kakaoMap.put("category", category);
		log.info(kakaoMap);
		model.addAttribute("kakaoMap", kakaoMap);
		return "/kakaojoin";
	}
	
	@PostMapping("/kakaojoin2")
	public void kakaojoin2(@RequestParam("username1") String id,
						   @RequestParam("pwd") String pwd,
						   @RequestParam("name") String name,
						   @RequestParam("gender") String gender,
						   @RequestParam("category") String category) throws Exception {
		Map<String, String> map = new HashMap<>();
		map.put("username", id);
		map.put("pwd", pwd);
		map.put("name", name);
		map.put("gender", gender);
		map.put("category", category);
		
	}
//	@PostMapping("/kakao")
//	public @ResponseBody String kakao(@RequestBody JSONObject kakaoInfo, Model model, RedirectAttributes rttr) throws Exception{
//		String name = (String)kakaoInfo.get("name");
//		String email = (String)kakaoInfo.get("email");
//		String gender = (String)kakaoInfo.get("gender");
//		String image = (String)kakaoInfo.get("image");
//		Map<String, String> kakaoMap = new HashMap<>();
//		kakaoMap.put("name", name);
//		kakaoMap.put("email", email);
//		kakaoMap.put("gender", gender);
//		kakaoMap.put("image", image);
//		rttr.addFlashAttribute("kakaoMap", kakaoMap);
//		return "kakaojoin";
//	}
	
	@GetMapping("/login")
	public String login(String error, String logout,
						@ModelAttribute("mDto") MemberDTO mDto) {
		return "/member/login";
		
	}
	
	@PostMapping("/loginPost")
	public String loginpost(@RequestParam("username") String id, @RequestParam("password") String pwd, Model model, HttpSession session) throws Exception {
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String returnUrl = "";
		MemberDTO mDto = memberService.read(id);
		Map<String, String> loginMap = new HashMap<>();
		if(mDto != null) {
			if(encoder.matches(pwd, mDto.getPwd())) {
				loginMap.put("id", id);
				loginMap.put("pwd", mDto.getPwd());
				MemberDTO memList = memberService.login(loginMap);
				session.setAttribute("memInfo", memList);
				returnUrl = "index";
			} else {
				returnUrl = "member/result/login_fail";
			}
		}else {
			returnUrl = "member/result/login_fail";
			
		}
		return returnUrl;
	}
	
	@GetMapping("/secLogin")
	public @ResponseBody String secLogin(Authentication auth,
						   HttpSession session
						   ) throws Exception{
		String returnUrl = "loginfail";
		log.info("id >>> " + auth.getName());
		MemberDTO mDto = memberService.read(auth.getName());
		if(mDto != null) {
			session.setAttribute("mDto", mDto);
			returnUrl = "loginsuccess";
		}
		return returnUrl;
	}
	@GetMapping("/secLoginPost")
	public @ResponseBody String secLoginPost(
			@RequestBody JSONObject member) throws Exception{
		log.info(member);
		String returnUrl = "member/result/login_fail";
//		log.info("id >>> " + auth.getName());
//		MemberDTO mDto = memberService.read(auth.getName());
//		session.setAttribute("mDto", mDto);
//		log.info("password >>> " + pwd);
//		loginMap.put("id", id);
//		loginMap.put("pwd", pwd);
//		MemberDTO mDto = memberService.login(loginMap);
//		session.setAttribute("mDto", mDto);
//		if(mDto != null) {
//			returnUrl = "redirect:/";
//		}
		return returnUrl;
	}
	
	@PostMapping("/login")
	public String secLoginPost() {
		return "member/login";
	}
	
	@GetMapping("/exitMem")
	public void exitMem(@RequestParam("id") String id) throws Exception {
		log.info("exit Mem id >>>> " + id);
	}
	
	@PostMapping("/shop")
	public @ResponseBody Map<String, String> shop(@RequestParam("data") String data) throws Exception {
		log.info(data);
		String clientId = "5QM_wfDAdLPm12A5by6q"; //?????????????????? ??????????????? ????????????"
		String clientSecret = "Dxo2BaBD_q"; //?????????????????? ??????????????? ????????????"
		try {
			data = URLEncoder.encode(data, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			throw new RuntimeException("????????? ????????? ??????",e);
		}
		String apiURL = "https://openapi.naver.com/v1/search/shop.json?query=" + data;
		Map<String, String> requestHeaders = new HashMap<>();
		requestHeaders.put("X-Naver-Client-Id", clientId);
		requestHeaders.put("X-Naver-Client-Secret", clientSecret);
		String responseBody = get(apiURL,requestHeaders);
		System.out.println("responsebody >>> " + responseBody);
		JSONParser parser = new JSONParser();
		JSONObject jsonObject = (JSONObject) parser.parse(responseBody);
		JSONArray items = (JSONArray) jsonObject.get("items");
		JSONObject result = (JSONObject) items.get(0);
		log.info("?????? ?????? ?????? >>>>> "+result);
		String image = (String) result.get("image");
		String title = (String) result.get("title");
		String lprice = (String) result.get("lprice");
		Map<String, String> ResultMap = new HashMap<>();
		ResultMap.put("image", image);
		ResultMap.put("title", title);
		ResultMap.put("lprice", lprice);
		return ResultMap;
	}
	
	public static String get(String apiUrl, Map<String, String> requestHeaders) throws Exception {
		HttpURLConnection con = connect(apiUrl);
		System.out.println("get url >>> "+con);
        try {
            con.setRequestMethod("GET");
            for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
                con.setRequestProperty(header.getKey(), header.getValue());
            }

            int responseCode = con.getResponseCode();
            System.out.println("resCode"+responseCode);
            if (responseCode == HttpURLConnection.HTTP_OK) { // ?????? ??????
                return readBody(con.getInputStream());
            } else { // ?????? ??????
                return readBody(con.getErrorStream());
            }
        } catch (IOException e) {
            throw new RuntimeException("API ????????? ?????? ??????", e);
        } finally {
            con.disconnect();
        }
	}
	
	public static HttpURLConnection connect(String apiUrl) throws Exception {
		try {
            URL url = new URL(apiUrl);
            return (HttpURLConnection)url.openConnection();
        } catch (MalformedURLException e) {
            throw new RuntimeException("API URL??? ?????????????????????. : " + apiUrl, e);
        } catch (IOException e) {
            throw new RuntimeException("????????? ??????????????????. : " + apiUrl, e);
        }
	}
	
	public static String readBody(InputStream body) throws Exception {
		InputStreamReader streamReader = new InputStreamReader(body);

        try (BufferedReader lineReader = new BufferedReader(streamReader)) {
            StringBuilder responseBody = new StringBuilder();


            String line;
            while ((line = lineReader.readLine()) != null) {
                responseBody.append(line);
            }

            return responseBody.toString();
        } catch (IOException e) {
            throw new RuntimeException("API ????????? ????????? ??????????????????.", e);
        }
	} // readyBody end
	
	@PostMapping(value = "/ySearch")
	public @ResponseBody List<TestDTO> youtube(@RequestParam("keyword") String keyword) throws Exception {
		log.info("?????? ?????? ?????? >>>> " + keyword);
		Properties properties = new Properties();
		try {
			InputStream in = Search.class.getResourceAsStream("/"+PROPERTIES_FILENAME);
			properties.load(in);
		} catch (IOException e) {
			System.err.println("There was an error reading " + PROPERTIES_FILENAME + ": " + e.getCause()
	          + " : " + e.getMessage());
			System.exit(1);
		}
		List<TestDTO> videoUrl = null;
		try {
			String queryTerm = keyword;
			youtube = new YouTube.Builder(HTTP_TRANSPORT, JSON_FACTORY, new HttpRequestInitializer() {
		        public void initialize(HttpRequest request) throws IOException {}
		      }).setApplicationName("youtube-cmdline-search-sample").build();
			
			
			YouTube.Search.List search = youtube.search().list("id,snippet");
			
			String apiKey = properties.getProperty("youtube.apikey");
			search.setKey(apiKey);
			search.setQ(queryTerm);
			search.setType("video");
			search.setFields("items(id/kind,id/videoId,snippet/title,snippet/thumbnails/high/url)");
			search.setMaxResults(NUMBER_OF_VIDEOS_RETURNED);
			SearchListResponse searchResponse = search.execute();
			
			List<SearchResult> searchResultList = searchResponse.getItems();
			if(searchResultList != null) {
				videoUrl = service.prettyPrint(searchResultList.iterator(), queryTerm);
			}
		} catch (GoogleJsonResponseException e) {
			System.err.println("There was a service error: " + e.getDetails().getCode() + " : "
			          + e.getDetails().getMessage());
		} catch (IOException e) {
			System.err.println("There was an IO error: " + e.getCause() + " : " + e.getMessage());
		} catch (Throwable t) {
			t.printStackTrace();
		}
		log.info("before return videoUrl >>> " + videoUrl);
		return videoUrl;
	}
}

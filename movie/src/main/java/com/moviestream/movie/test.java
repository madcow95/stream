package com.moviestream.movie;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;

import com.google.api.client.googleapis.json.GoogleJsonResponseException;
import com.google.api.client.http.HttpRequest;
import com.google.api.client.http.HttpRequestInitializer;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.services.youtube.YouTube;
import com.google.api.services.youtube.YouTube.Search;
import com.google.api.services.youtube.model.ResourceId;
import com.google.api.services.youtube.model.SearchListResponse;
import com.google.api.services.youtube.model.SearchResult;
import com.google.api.services.youtube.model.Thumbnail;

public class test {
	private static String PROPERTIES_FILENAME = "youtube.properties";
	private static final HttpTransport HTTP_TRANSPORT = new NetHttpTransport();
	private static final JsonFactory JSON_FACTORY = new JacksonFactory();
	private static final long NUMBER_OF_VIDEOS_RETURNED = 1;
	private static YouTube youtube;

	public static void main(String[] args) {
		Properties properties = new Properties();
	    try {
	      InputStream in = Search.class.getResourceAsStream("/" + PROPERTIES_FILENAME);
	      properties.load(in);

	    } catch (IOException e) {
	      System.err.println("There was an error reading " + PROPERTIES_FILENAME + ": " + e.getCause()
	          + " : " + e.getMessage());
	      System.exit(1);
	    }
	    
	    try {
	        youtube = new YouTube.Builder(HTTP_TRANSPORT, JSON_FACTORY, new HttpRequestInitializer() {
	          public void initialize(HttpRequest request) throws IOException {}
	        }).setApplicationName("youtube-cmdline-search-sample").build();

	        String queryTerm = getInputQuery();

	        YouTube.Search.List search = youtube.search().list("id,snippet");
	        String apiKey = properties.getProperty("youtube.apikey");
	        search.setKey(apiKey);
	        search.setQ(queryTerm);
	        search.setType("video");
	        search.setFields("items(id/kind,id/videoId,snippet/title,snippet/thumbnails/high/url)");
	        search.setMaxResults(NUMBER_OF_VIDEOS_RETURNED);
	        SearchListResponse searchResponse = search.execute();

	        List<SearchResult> searchResultList = searchResponse.getItems();

	        if (searchResultList != null) {
	          prettyPrint(searchResultList.iterator(), queryTerm);
	        }
	      } catch (GoogleJsonResponseException e) {
	        System.err.println("There was a service error: " + e.getDetails().getCode() + " : "
	            + e.getDetails().getMessage());
	      } catch (IOException e) {
	        System.err.println("There was an IO error: " + e.getCause() + " : " + e.getMessage());
	      } catch (Throwable t) {
	        t.printStackTrace();
	      }
	    }
	
	 private static String getInputQuery() throws IOException {

		    String inputQuery = "";

		    System.out.print("Please enter a search term: ");
		    BufferedReader bReader = new BufferedReader(new InputStreamReader(System.in));
		    inputQuery = bReader.readLine();

		    if (inputQuery.length() < 1) {
		      // If nothing is entered, defaults to "YouTube Developers Live."
		      inputQuery = "YouTube Developers Live";
		    }
		    return inputQuery;
		  }
	 
	 private static void prettyPrint(Iterator<SearchResult> iteratorSearchResults, String query) {

		    System.out.println("\n=============================================================");
		    System.out.println(
		        "   First " + NUMBER_OF_VIDEOS_RETURNED + " videos for search on \"" + query + "\".");
		    System.out.println("=============================================================\n");

		    if (!iteratorSearchResults.hasNext()) {
		      System.out.println(" There aren't any results for your query.");
		    }

		    while (iteratorSearchResults.hasNext()) {

		      SearchResult singleVideo = iteratorSearchResults.next();
		      ResourceId rId = singleVideo.getId();

		      // Double checks the kind is video.
		      if (rId.getKind().equals("youtube#video")) {
		        Thumbnail thumbnail = (Thumbnail) singleVideo.getSnippet().getThumbnails().get("high");

		        System.out.println(" Video Id >>> " + rId.getVideoId());
		        System.out.println(" Title: " + singleVideo.getSnippet().getTitle());
		        System.out.println(" Thumbnail: " + thumbnail.getUrl());
		        System.out.println("\n-------------------------------------------------------------\n");
		      }
		    }
		  }
	}

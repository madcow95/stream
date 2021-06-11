package com.moviestream.movie;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
//@ComponentScan(basePackages = "com.moviestream.movie.board.service")
//@ComponentScan(basePackages = "com.moviestream.movie.board.task")
//
//@EnableAspectJAutoProxy
//@EnableScheduling
//@EnableTransactionManagement
//
//@MapperScan(basePackages = "com.moviestream.movie.board.mapper")
public class RootConfig {

}

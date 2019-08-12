package kr.co.passcombine.mes.scheduler;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.annotation.Resource;
 



import kr.co.passcombine.mes.svc.SYOrganService;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;


@Component
@PropertySource("classpath:/app.properties")
public class BatchJobScheduler {
	private static final Logger logger = LoggerFactory.getLogger(BatchJobScheduler.class);

	@Resource
	private Environment environment;
 
	
	  
}

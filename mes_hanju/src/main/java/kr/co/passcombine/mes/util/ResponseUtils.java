package kr.co.passcombine.mes.util;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import kr.co.passcombine.mes.vo.CommonMessage;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;

public class ResponseUtils {
	private static final Logger logger = LoggerFactory.getLogger(ResponseUtils.class);
	private static ObjectMapper gMapper = new ObjectMapper();

	public static String getJsonResponse(HttpServletResponse response, Object param) {
		String rstResponse = null;
		String errMsg = "";
		try {
			rstResponse = gMapper.writeValueAsString(param);
		} catch (JsonGenerationException e) {
			rstResponse = null;
			errMsg = e.getMessage();
			logger.error(e.getMessage(), e);
		} catch (JsonMappingException e) {
			rstResponse = null;
			errMsg = e.getMessage();
			logger.error(e.getMessage(), e);
		} catch (IOException e) {
			rstResponse = null;
			errMsg = e.getMessage();
			logger.error(e.getMessage(), e);
		}

		if (rstResponse == null) {
			response.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
			return makeErrorJson(errMsg);
		} else {
			response.setStatus(HttpStatus.OK.value());
			return rstResponse;
		}
	}

	 public static String getJsonResponse(Object param) {
	    String rstResponse = null;
	    String errMsg = "";
	    try {
	      rstResponse = gMapper.writeValueAsString(param);

	    } catch (JsonGenerationException e) {
	      rstResponse = null;
	      errMsg = e.getMessage();
	      logger.error(e.getMessage(), e);
	    } catch (JsonMappingException e) {
	      rstResponse = null;
	      errMsg = e.getMessage();
	      logger.error(e.getMessage(), e);
	    } catch (IOException e) {
	      rstResponse = null;
	      errMsg = e.getMessage();
	      logger.error(e.getMessage(), e);
	    }

	    if (rstResponse == null) {
	      return makeErrorJson(errMsg);
	    } else {
	      return rstResponse;
	    }
	  }
	
	public static String getSuccessMsgResponse(HttpServletResponse response, String msg) {
		String successJson = "";
		try {
			CommonMessage successResult = new CommonMessage();
			successResult.setMessage(msg);
			successJson = gMapper.writeValueAsString(successResult);

		} catch (JsonGenerationException e) {
			logger.error(e.getMessage(), e);
		} catch (JsonMappingException e) {
			logger.error(e.getMessage(), e);
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		}
		return successJson;
	}

	public static String getSimpleSucessResponse(HttpServletResponse response) {
		String successJson = "";
		try {
			CommonMessage successResult = new CommonMessage();
			successResult.setMessage("");
			successJson = gMapper.writeValueAsString(successResult);

		} catch (JsonGenerationException e) {
			logger.error(e.getMessage(), e);
		} catch (JsonMappingException e) {
			logger.error(e.getMessage(), e);
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		}
		return successJson;
	}

	public static String getSimpleErrorResponse(HttpServletResponse response) {
		String errorJson = "";
		try {
			CommonMessage errorResult = new CommonMessage();
			errorResult.setMessage("");
			errorJson = gMapper.writeValueAsString(errorResult);
		} catch (JsonGenerationException e) {
			logger.error(e.getMessage(), e);
		} catch (JsonMappingException e) {
			logger.error(e.getMessage(), e);
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		}
		response.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
		return errorJson;
	}

	private static String makeErrorJson(String errMsg) {
		String errorJson = "";
		try {
			CommonMessage errorResult = new CommonMessage();
			errorResult.setMessage(errMsg);
			errorJson = gMapper.writeValueAsString(errorResult);
		} catch (JsonGenerationException e) {
			logger.error(e.getMessage(), e);
		} catch (JsonMappingException e) {
			logger.error(e.getMessage(), e);
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		}
		return errorJson;
	}

	@SuppressWarnings("unchecked")
	public static JSONObject getJQGridJsonResponse(HttpServletResponse response, List<?> listData, int currentPage, int pageRows, int totalRows) {
		
		JSONObject resultData = new JSONObject();
		JSONParser jsonParser = new JSONParser();
		JSONArray listDataJArray = new JSONArray();
		int totalPages = 1;
		try {
			if (totalRows > -1) {
				totalPages = (int) Math.ceil((double) totalRows / (double) pageRows);
			} else {
				totalPages = 1;
				totalRows = listData.size();
			}

			String listDataJsonString = ResponseUtils.getJsonResponse(response, listData);
			response.setStatus(HttpStatus.OK.value());
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("RESULT", "success");
			resultData.put("page", currentPage);
			resultData.put("total", totalPages);
			resultData.put("records", totalRows);
			resultData.put("list_data", listDataJArray);
		} catch (Exception e) {
			response.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("RESULT", "fail");
			resultData.put("page", "1");
			resultData.put("total", "1");
			resultData.put("records", 0);
			resultData.put("list_data", listDataJArray);
		}
		resultData.put("RESULT", "success");
		resultData.put("page", currentPage);
		resultData.put("total", totalPages);
		resultData.put("records", totalRows);
		resultData.put("list_data", listDataJArray);

		return resultData;
	}
	
	@SuppressWarnings("unchecked")
	public static JSONObject getDhtmlxGridJsonResponse(HttpServletResponse response, List<?> listData, int currentPage, int pageRows, int totalRows) {
		JSONObject resultData = new JSONObject();
		JSONParser jsonParser = new JSONParser();
		JSONArray listDataJArray = new JSONArray();
		
		try {
			int totalPages = 1;
			if (totalRows > -1) {
				totalPages = (int) Math.ceil((double) totalRows / (double) pageRows);
			} else {
				totalPages = 1;
				totalRows = listData.size();
			}
			String listDataJsonString = ResponseUtils.getJsonResponse(response, listData);
			response.setStatus(HttpStatus.OK.value());
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("total_count", totalRows);
			resultData.put("pos", currentPage-1);
			resultData.put("data", listDataJArray);
		} catch (Exception e) {
			response.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("total_count", "0");
			resultData.put("pos", "0");
			resultData.put("data", listDataJArray);
		}
		return resultData;
	}

	public static JSONObject getJsonObject(Object param) {
		String rstResponse = null;
		JSONObject resultObject = new JSONObject();
		JSONParser jsonParser = new JSONParser();
		try {
			rstResponse = gMapper.writeValueAsString(param);
			resultObject = (JSONObject) jsonParser.parse(rstResponse);
		} catch (JsonGenerationException e) {
			resultObject = null;
			logger.error(e.getMessage(), e);
		} catch (JsonMappingException e) {
			resultObject = null;
			logger.error(e.getMessage(), e);
		} catch (IOException e) {
			resultObject = null;
			logger.error(e.getMessage(), e);
		} catch (Exception e) {
			resultObject = null;
			logger.error(e.getMessage(), e);
		}

		return resultObject;
	}
}

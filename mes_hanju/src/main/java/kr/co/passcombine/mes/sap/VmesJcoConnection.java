package kr.co.passcombine.mes.sap;

import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.sap.conn.jco.JCoContext;
import com.sap.conn.jco.JCoDestination;
import com.sap.conn.jco.JCoDestinationManager;
import com.sap.conn.jco.JCoException;
import com.sap.conn.jco.JCoFunction;
import com.sap.conn.jco.JCoRepository;
import com.sap.conn.jco.ext.*;

public class VmesJcoConnection {
	private static final Logger logger = LoggerFactory.getLogger(VmesJcoConnection.class);
	private final static String DESTINATION_NAME = "V-ERP";
	private JCoRepository repos;
	private JCoDestination dest;
	private final Properties connectProperties;
	
	public VmesJcoConnection(VmesJcoConnectVo connectVo) {
		connectProperties = new Properties();
		
	 
		if(connectVo.getJco_ashost()==null){
			connectProperties.setProperty(DestinationDataProvider.JCO_MSHOST, connectVo.getJco_mshost());
			connectProperties.setProperty(DestinationDataProvider.JCO_R3NAME, connectVo.getJco_r3name());
			connectProperties.setProperty(DestinationDataProvider.JCO_GROUP, connectVo.getJco_group());
		}else{
			connectProperties.setProperty(DestinationDataProvider.JCO_ASHOST, connectVo.getJco_ashost());
		}
		 
		connectProperties.setProperty(DestinationDataProvider.JCO_SYSNR, connectVo.getJco_sysnr());
		connectProperties.setProperty(DestinationDataProvider.JCO_CLIENT, connectVo.getJco_client());
		connectProperties.setProperty(DestinationDataProvider.JCO_USER, connectVo.getJco_user());
		connectProperties.setProperty(DestinationDataProvider.JCO_PASSWD, connectVo.getJco_passwd());
		connectProperties.setProperty(DestinationDataProvider.JCO_LANG, connectVo.getJco_lang());
		connectProperties.setProperty(DestinationDataProvider.JCO_POOL_CAPACITY, connectVo.getJco_pool_capacity());
		connectProperties.setProperty(DestinationDataProvider.JCO_PEAK_LIMIT, connectVo.getJco_peak_limit());
		connectProperties.setProperty(DestinationDataProvider.JCO_PCS, connectVo.getJco_pcs());
		
		VmesDestinationDataProvider fProvider = new VmesDestinationDataProvider();
		fProvider.changeProperties(DESTINATION_NAME, connectProperties);
		try {
			Environment.registerDestinationDataProvider(fProvider);
		} catch(Exception e){
			// logger.debug(e.toString());
		}
		
		try {
			dest = JCoDestinationManager.getDestination(DESTINATION_NAME);
			dest.ping();
			repos = dest.getRepository();
		} catch (JCoException e) {
			throw new RuntimeException(e);
		}
	}
	
	public JCoFunction getFunction(String functionStr) {
		JCoFunction function = null;
		try {
			function = repos.getFunction(functionStr);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("Problem retrievingJCO.Function object.");
		}
		
		if (function == null) {
			throw new RuntimeException("Not possible to receive function.");
		}
		return function;
	}

	public void executeFunction(JCoFunction function) {
		try {
			JCoContext.begin(dest);
			function.execute(dest);
			JCoContext.end(dest);
		} catch (JCoException e) {
			e.printStackTrace();
		}
	}
}
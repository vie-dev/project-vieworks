package kr.co.passcombine.mes.sap;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;

import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;

import com.sap.conn.jco.JCoException;
import com.sap.conn.jco.JCoFunction;
import com.sap.conn.jco.JCoTable;
import com.sap.conn.jco.ext.*;
import com.sap.conn.jco.server.JCoServer;
import com.sap.conn.jco.server.JCoServerContext;
import com.sap.conn.jco.server.JCoServerFactory;
import com.sap.conn.jco.server.JCoServerFunctionHandler;
import com.sap.conn.jco.server.JCoServerFunctionHandlerFactory;
import com.sap.conn.jco.server.JCoServerState;

@PropertySource("classpath:/app.properties")
public class VmesJcoServer {
	private final static String SERVER_NAME = "ZIFRPOPR001";
	private final static String DESTINATION_NAME = "ZIFRPOPR001";
	
	private final Properties connectProperties;
	private final Properties serverProperties;
	
	private static JCoServer server;
	
	private static Environment environment;
	
	@Resource
	public void setEnvironment(Environment environment){
		VmesJcoServer.environment = environment;
	}
	
	public VmesJcoServer(String ashost, String sysnr, String client, String user, String passwd, String lang, String pool_capacity, String peak_limit, String pcs
			, String gwhost, String connection_count, String gwserv, String progid, String rep_dest) {
		
		connectProperties = new Properties();
		connectProperties.setProperty(DestinationDataProvider.JCO_ASHOST, ashost);
		connectProperties.setProperty(DestinationDataProvider.JCO_SYSNR, sysnr);
		connectProperties.setProperty(DestinationDataProvider.JCO_CLIENT, client);
		connectProperties.setProperty(DestinationDataProvider.JCO_USER, user);
		connectProperties.setProperty(DestinationDataProvider.JCO_PASSWD, passwd);
		connectProperties.setProperty(DestinationDataProvider.JCO_LANG, lang);
		connectProperties.setProperty(DestinationDataProvider.JCO_POOL_CAPACITY, pool_capacity);
		connectProperties.setProperty(DestinationDataProvider.JCO_PEAK_LIMIT, peak_limit);
		connectProperties.setProperty(DestinationDataProvider.JCO_PCS, pcs);
		
		serverProperties = new Properties();
		serverProperties.setProperty(ServerDataProvider.JCO_GWHOST, gwhost);
		serverProperties.setProperty(ServerDataProvider.JCO_CONNECTION_COUNT, connection_count);
		serverProperties.setProperty(ServerDataProvider.JCO_GWSERV, gwserv);
		serverProperties.setProperty(ServerDataProvider.JCO_PROGID, progid);
		serverProperties.setProperty(ServerDataProvider.JCO_REP_DEST, rep_dest);
		
		VmesDestinationDataProvider fProvider = new VmesDestinationDataProvider();
		VmesServerDataProvider sProvider = new VmesServerDataProvider();
		
		fProvider.changeProperties(DESTINATION_NAME, connectProperties);
		sProvider.changeProperties(SERVER_NAME, serverProperties);
		
		try {
			com.sap.conn.jco.ext.Environment.registerServerDataProvider(sProvider);
			com.sap.conn.jco.ext.Environment.registerDestinationDataProvider(fProvider);
		} catch(Exception e){
			System.out.println(e.toString());
		}
		System.out.println("=====================================================================");
		System.out.println("[SAP/JCO Server] JCO Server Configure");
		System.out.println("[SAP/JCO Server] JCO Server Conf : JCO_ASHOST : " + ashost);
		System.out.println("[SAP/JCO Server] JCO Server Conf : JCO_SYSNR : " + sysnr);
		System.out.println("[SAP/JCO Server] JCO Server Conf : JCO_CLIENT : " + client);
		System.out.println("[SAP/JCO Server] JCO Server Conf : JCO_USER : " + user);
		System.out.println("[SAP/JCO Server] JCO Server Conf : JCO_PASSWD : " + passwd);
		System.out.println("[SAP/JCO Server] JCO Server Conf : JCO_LANG : " + lang);
		System.out.println("[SAP/JCO Server] JCO Server Conf : JCO_POOL_CAPACITY : " +pool_capacity);
		System.out.println("[SAP/JCO Server] JCO Server Conf : JCO_PEAK_LIMIT : " +peak_limit);
		System.out.println("[SAP/JCO Server] JCO Server Conf : JCO_PCS : " +pcs);
		
		System.out.println("[SAP/JCO Server] JCO Server Conf : JCO_GWHOST : " +gwhost);
		System.out.println("[SAP/JCO Server] JCO Server Conf : JCO_CONNECTION_COUNT : " +connection_count);
		System.out.println("[SAP/JCO Server] JCO Server Conf : JCO_GWSERV : " +gwserv);
		System.out.println("[SAP/JCO Server] JCO Server Conf : JCO_PROGID : " +progid);
		System.out.println("[SAP/JCO Server] JCO Server Conf : JCO_REP_DEST : " +rep_dest);
		System.out.println("=====================================================================");
		try {
			server = JCoServerFactory.getServer(SERVER_NAME);
		} catch (JCoException e) {
			throw new RuntimeException("Unable to create the server " + SERVER_NAME + ", because of " + e.getMessage(), e);
		}
		System.out.println("[SAP/JCO Server] JCO Server PrevStatus : " + server.getState().toString());
		System.out.println("[SAP/JCO Server] JCO Server Valid : " + server.isValid());
		
		if(server.getState() != JCoServerState.STOPPED) {
			server.stop();
			server.release();
	    server.removeThroughput();
		}
		
		while(server.getState() != JCoServerState.STOPPED) {
			try {
				for (int i = 1; i <= 5; i++) {
					Thread.sleep(1000);
				}
				System.out.println("[SAP/JCO Server] JCO Server ReleaseStatus : " + server.getState().toString());
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		
		server.setCallHandlerFactory(new FaisFunctionHandlerFactory());
		server.start();
		
		System.out.println("[SAP/JCO Server] JCO Server Start : " + server.getState().toString());
		System.out.println("[SAP/JCO Server] JCO Server is started.");
		try {
			for (int i = 1; i <= 5; i++) {
				System.out.println("[SAP/JCO Server] JCO Server Thread StartStatus : " + server.getState().toString());
				Thread.sleep(2000);
			}
			System.out.println("[SAP/JCO Server] JCO Server Thread StartStatus : " + server.getState().toString());
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}
	
	@SuppressWarnings("unused")
	private static void getStatus(){
		System.out.println("[SAP/JCO Server] JCO Server CallStatus : " + server.getState().toString());
	}
	
	static class FaisFunctionHandlerFactory implements JCoServerFunctionHandlerFactory {
		class SessionContext {
			Hashtable<String, Object> cachedSessionData = new Hashtable<String, Object>();
		}
		
		private Map<String, SessionContext> statefulSessions = new Hashtable<String, SessionContext>();
		
		@Override
		public void sessionClosed(JCoServerContext serverCtx, String message, boolean error) {
			System.out.println("[SAP/JCO Server] error : " + error);
			System.out.println("[SAP/JCO Server] Session " + serverCtx.getSessionID() + " was closed " + (error ? message : "by SAP system"));
			statefulSessions.remove(serverCtx.getSessionID());
		}

		@Override
		public JCoServerFunctionHandler getCallHandler(JCoServerContext serverCtx, String functionName) {
			JCoServerFunctionHandler handler = null;
			System.out.println("[SAP/JCO Server] RFC Call : Function Name : " + functionName);
			
			if (handler instanceof StatefulFunctionModule) {
				SessionContext cachedSession;
				if (!serverCtx.isStatefulSession()) {
					serverCtx.setStateful(true);
					cachedSession = new SessionContext();
					statefulSessions.put(serverCtx.getSessionID(), cachedSession);
				} else {
					cachedSession = statefulSessions.get(serverCtx.getSessionID());
					if (cachedSession == null)
						throw new RuntimeException("Unable to find the session context for session id " + serverCtx.getSessionID());
				}
				((StatefulFunctionModule) handler).setSessionData(cachedSession.cachedSessionData);
				return handler;
			}
			return null;
		}
	}
	
	public static abstract class StatefulFunctionModule implements JCoServerFunctionHandler {
		Hashtable<String, Object> sessionData;
		public void setSessionData(Hashtable<String, Object> sessionData) {
			this.sessionData = sessionData;
		}
	}
}
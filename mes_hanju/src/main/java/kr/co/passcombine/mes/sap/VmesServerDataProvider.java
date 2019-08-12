package kr.co.passcombine.mes.sap;

import java.util.Properties;

import com.sap.conn.jco.ext.*;

public class VmesServerDataProvider implements ServerDataProvider {

	static String SAP_SERVER = "SAP_SERVER";
	private ServerDataEventListener eventListener;
	private Properties ABAP_AS_properties;
	
	public boolean supportsEvents() {
		return true;
	}

	public void changeProperties(String destName, Properties properties) {
		if (properties == null) {
			eventListener.deleted("SAP_SERVER");
			ABAP_AS_properties = null;
		} else {
			if (ABAP_AS_properties != null && !ABAP_AS_properties.equals(properties))
				eventListener.updated("SAP_SERVER");
			ABAP_AS_properties = properties;
		}
	}

	@Override
	public Properties getServerProperties(String arg0) {
		return ABAP_AS_properties;
	}

	@Override
	public void setServerDataEventListener(ServerDataEventListener eventListener) {
		this.eventListener = eventListener;
	}
}

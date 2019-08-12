package kr.co.passcombine.mes.sap;

import java.util.Properties;
import com.sap.conn.jco.ext.*;

public class VmesDestinationDataProvider implements DestinationDataProvider {

	static String SAP_SERVER = "SAP_SERVER";
	private DestinationDataEventListener eventListener;
	private Properties ABAP_AS_properties;

	public Properties getDestinationProperties(String destinationName) {
		return ABAP_AS_properties;
	}

	public void setDestinationDataEventListener(DestinationDataEventListener eventListener) {
		this.eventListener = eventListener;
	}

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
}

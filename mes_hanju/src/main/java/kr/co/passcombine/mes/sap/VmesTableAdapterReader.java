package kr.co.passcombine.mes.sap;

import com.sap.conn.jco.JCoTable;

public class VmesTableAdapterReader {
	protected JCoTable table;

	public VmesTableAdapterReader(JCoTable table) {
		this.table = table;
	}

	public String get(String s) {
		return table.getString(s);
	}

	public Boolean getBoolean(String s) {
		String value = table.getValue(s).toString();
		return value.equals("x");
	}

	public String getMessage() {
		return table.getString("MESSAGE");
	}

	public int size() {
		return table.getNumRows();
	}

	public void next() {
		table.nextRow();
	}
}

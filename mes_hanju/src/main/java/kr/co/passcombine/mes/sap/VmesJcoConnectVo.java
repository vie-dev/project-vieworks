package kr.co.passcombine.mes.sap;

import org.springframework.core.env.Environment;

public class VmesJcoConnectVo {
	
	private String jco_ashost;
	private String jco_mshost;
	private String jco_r3name;
	private String jco_group;


	private String jco_sysnr;
	private String jco_client;
	private String jco_user;
	private String jco_passwd;
	@Override
	public String toString() {
		return "VmesJcoConnectVo [jco_ashost=" + jco_ashost + ", jco_mshost="
				+ jco_mshost + ", jco_r3name=" + jco_r3name + ", jco_group="
				+ jco_group + ", jco_sysnr=" + jco_sysnr + ", jco_client="
				+ jco_client + ", jco_user=" + jco_user + ", jco_passwd="
				+ jco_passwd + ", jco_lang=" + jco_lang
				+ ", jco_pool_capacity=" + jco_pool_capacity
				+ ", jco_peak_limit=" + jco_peak_limit + ", jco_pcs=" + jco_pcs
				+ "]";
	}

	public String getJco_group() {
		return jco_group;
	}

	public void setJco_group(String jco_group) {
		this.jco_group = jco_group;
	}

	public String getJco_r3name() {
		return jco_r3name;
	}

	public void setJco_r3name(String jco_r3name) {
		this.jco_r3name = jco_r3name;
	}
	
	public String getJco_mshost() {
		return jco_mshost;
	}

	public void setJco_mshost(String jco_mshost) {
		this.jco_mshost = jco_mshost;
	}

	private String jco_lang;
	private String jco_pool_capacity;
	private String jco_peak_limit;
	private String jco_pcs;
	
	public VmesJcoConnectVo(Environment env) {
		jco_ashost = env.getProperty("jco.ashost");
		jco_r3name = env.getProperty("jco.r3name");
		jco_mshost = env.getProperty("jco.mshost");
		jco_group = env.getProperty("jco.group");
		jco_sysnr = env.getProperty("jco.sysnr");
		jco_client = env.getProperty("jco.client");
		jco_user = env.getProperty("jco.user");
		jco_passwd = env.getProperty("jco.passwd");
		jco_lang = env.getProperty("jco.lang");
		jco_pool_capacity = env.getProperty("jco.pool_capacity");
		jco_peak_limit = env.getProperty("jco.peak_limit");
		jco_pcs = env.getProperty("jco.pcs");
	}
	
	public String getJco_ashost() {
		return jco_ashost;
	}

	public void setJco_ashost(String jco_ashost) {
		this.jco_ashost = jco_ashost;
	}

	public String getJco_sysnr() {
		return jco_sysnr;
	}

	public void setJco_sysnr(String jco_sysnr) {
		this.jco_sysnr = jco_sysnr;
	}

	public String getJco_client() {
		return jco_client;
	}

	public void setJco_client(String jco_client) {
		this.jco_client = jco_client;
	}

	public String getJco_user() {
		return jco_user;
	}

	public void setJco_user(String jco_user) {
		this.jco_user = jco_user;
	}

	public String getJco_passwd() {
		return jco_passwd;
	}

	public void setJco_passwd(String jco_passwd) {
		this.jco_passwd = jco_passwd;
	}

	public String getJco_lang() {
		return jco_lang;
	}

	public void setJco_lang(String jco_lang) {
		this.jco_lang = jco_lang;
	}

	public String getJco_pool_capacity() {
		return jco_pool_capacity;
	}

	public void setJco_pool_capacity(String jco_pool_capacity) {
		this.jco_pool_capacity = jco_pool_capacity;
	}

	public String getJco_peak_limit() {
		return jco_peak_limit;
	}

	public void setJco_peak_limit(String jco_peak_limit) {
		this.jco_peak_limit = jco_peak_limit;
	}

	public String getJco_pcs() {
		return jco_pcs;
	}

	public void setJco_pcs(String jco_pcs) {
		this.jco_pcs = jco_pcs;
	}	
}

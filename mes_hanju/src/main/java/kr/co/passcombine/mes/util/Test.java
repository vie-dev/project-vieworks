package kr.co.passcombine.mes.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Test {
	private static String REGEX = "select \\'\\d{6}\\'";
   private static String INPUT = "The select '111111' says meow. " + "All select '111111' say meow.";
   private static String REPLACE = "select fn_get_max_member_charge_use_seq()";

	public static void main(String[] args) {
		/*String sql = "INSERT INTO 'member_charge_use_his_with' ( p_seq , payment_member_id , payment_member_yn ," 
				 + "with_member_id , with_place_code , with_company_code , with_dept_code , year , month , charge_use_amt , tot_charge_use_amt , charge_use_datetime , store_code , menu_id , menu_name , menu_price , menu_count , menu_tf_price , event_id , charge_type , status_code , cancel_date , payment_group_id , point_type , charge_yn , point_adj_type , creator , create_date , updater , update_date )"
				 + " SELECT '111111' , 'MB_17072618291882WS-1TJ4-VZ' , 'Y' , member_id , place_code , company_code , dept_code , '2019' , '03' , 5500 , 5500 , NOW() , 'ST_170726105613WN09-EG1V-M4' , 'MN_170726110335Z37D-TKKK-30' , (SELECT tmp.menu_name FROM store_menu tmp WHERE tmp.menu_id = 'MN_170726110335Z37D-TKKK-30') , 5500 , 1 , 0 , NULL , 'O' , '50100' , NULL , 'PG_190303183027SL0C-CHRV-BV' , 'C' , 'N' , '370400' , 'MB_17072618291882WS-1TJ4-VZ' , NOW() , 'MB_17072618291882WS-1TJ4-VZ' , NOW() FROM member_master mm WHERE mm.member_id = 'MB_17072618291882WS-1TJ4-VZ'";
//		sql.replaceAll("SELECT(\\W)\\'\\d{6}\\'", "select fn_get_max_member_charge_use_seq()");
		sql.replaceAll("\\'[0-9]{6})\\'", "fn_get_max_member_charge_use_seq()");
		System.out.println(sql);
		*/
		Pattern p = Pattern.compile(REGEX);
	      
	      // get a matcher object
	      Matcher m = p.matcher(INPUT); 
	      INPUT = m.replaceAll(REPLACE);
	      System.out.println(INPUT);
	}
}

package com.syau.po;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * <strong>习题和在线测试的实体类</strong>
 *
 */
@Entity
@Table(name="TB_PRAXIS")
public class PraxisBean {
/*习题的ID*/
@Id
@Column(name="PRAXIS_ID")
 private String praxisId;
/*习题的内容*/
@Column(name="PRAXIS_INFO")
private String praxisInfo;
@Column(name="DEL_FLG")
private int delFlg;
public String getPraxisId() {
	return praxisId;
}
public void setPraxisId(String praxisId) {
	this.praxisId = praxisId;
}
public String getPraxisInfo() {
	return praxisInfo;
}
public void setPraxisInfo(String praxisInfo) {
	this.praxisInfo = praxisInfo;
}
public int getDelFlg() {
	return delFlg;
}
public void setDelFlg(int delFlg) {
	this.delFlg = delFlg;
}

}

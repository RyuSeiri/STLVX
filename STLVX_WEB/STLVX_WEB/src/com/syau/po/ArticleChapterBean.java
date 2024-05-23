package com.syau.po;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
/**
 * 文章节章节一些信息的实体类
 * @author Dell
 *
 */
@Entity
@Table(name="TB_CHAPTER")
public class ArticleChapterBean {
	@Id
	@Column(name = "CHAPTER_ID")
    private String Chapterid;
	@Column(name = "CHAPTER_INFO")
	private String Chapterinfo;
	@Column(name = "DEL_FLG")
	private int del_flg;
	public String getChapterid() {
		return Chapterid;
	}
	public void setChapterid(String chapterid) {
		Chapterid = chapterid;
	}
	public String getChapterinfo() {
		return Chapterinfo;
	}
	public void setChapterinfo(String chapterinfo) {
		Chapterinfo = chapterinfo;
	}
	public int getDel_flg() {
		return del_flg;
	}
	public void setDel_flg(int del_flg) {
		this.del_flg = del_flg;
	}

	public static final String ChapterTitle[] = { "第一章节", "第二章节", "第三章节",
			"第四章节", "第五章节", "第六章节", "第七章节", "第八章节", "第九章节", "第十章节", "第十一章节",
			"第十二章节", "第十三章节", "第十四章节", "第十五章节", "第十六章节", "第十七章节", "第十八章节",
			"第十九章节", "第二十章节", "第二十一章节", "第二十二章节", "第二十三章节", "第二十四章节", "第二十五章节",
			"第二十六章节", "第二十七章节", "第二十八章节", "第二十九章节", "第三十章节", "第三十一章节",
			"第三十二章节", "第三十三章节", "第三十四章节", "第三十五章节", "第三十六章节", "第三十七章节",
			"第三十八章节", "第三十九章节", "第四十章节", "第四十一章节", "第四十二章节", "第四十三章节",
			"第四十四章节", "第四十五章节", "第四十六章节", "第四十七章节", "第四十八章节", "第四十九章节",
			"第五十章节", "第五十一章节", "第五十二章节", "第五十三章节", "第五十四章节", "第五十五章节",
			"第五十六章节", "第五十七章节", "第五十八章节", "第五十九章节", "第六十章节" };

	public static String getChapterTitle(int chapterId) {
		return ChapterTitle[chapterId];
	}
	
}

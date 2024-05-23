package com.syau.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.syau.po.ArticleBean;
import com.syau.po.FileBean;
import com.syau.po.PageInfoBean;
import com.syau.service.ArticleService;
import com.syau.util.Util;

@Controller
@RequestMapping("index.do")
public class ShowIndexController {
	@Resource
	private ArticleService articleService;

	public ArticleService getArticleService() {
		return articleService;
	}

	public void setArticleService(ArticleService articleService) {
		this.articleService = articleService;
	}

	/**
	 * 查询首页理论教学列表
	 * 
	 * @return
	 */
	@RequestMapping(params = "method=selectLljxActicleForIndex", method = RequestMethod.POST)
	public @ResponseBody List<PageInfoBean> selectLljxActicleForIndex() {
		List<ArticleBean> result = new ArrayList<ArticleBean>();
		result = articleService.selectLljxActicleForIndex();
		int showArtcleCnt = 12;
		int addSpaceArtcleCnt = 0;

		List<PageInfoBean> pageInfoList = new ArrayList<PageInfoBean>();
		if (result != null && result.size() > 0) {
			pageInfoList = formatIndexArticleList(result, 20, 0);
		}
		if (pageInfoList.size() <= 12) {
			addSpaceArtcleCnt = showArtcleCnt - pageInfoList.size();
		}
		Util util = new Util();
		for (int i = 0; i < addSpaceArtcleCnt; i++) {
			pageInfoList.add(util.makeSpacePageInfo());
		}
		return pageInfoList;
	}

	/**
	 * 查询首页授课视频列表
	 * 
	 * @return
	 */
	@RequestMapping(params = "method=selectSkspActicleForIndex", method = RequestMethod.POST)
	public @ResponseBody List<PageInfoBean> selectSkspActicleForIndex() {
		List<ArticleBean> result = new ArrayList<ArticleBean>();
		result = articleService.selectSkspActicleForIndex();
		int showArtcleCnt = 12;
		int addSpaceArtcleCnt = 0;

		List<PageInfoBean> pageInfoList = new ArrayList<PageInfoBean>();
		if (result != null && result.size() > 0) {
			pageInfoList = formatIndexArticleList(result, 20, 0);
		}

		if (pageInfoList.size() <= 12) {
			addSpaceArtcleCnt = showArtcleCnt - pageInfoList.size();
		}
		Util util = new Util();
		for (int i = 0; i < addSpaceArtcleCnt; i++) {
			pageInfoList.add(util.makeSpacePageInfo());
		}
		return pageInfoList;
	}

	/**
	 * 查询首页课程案例列表
	 * 
	 * @return
	 */
	@RequestMapping(params = "method=selectKcalActicleForIndex", method = RequestMethod.POST)
	public @ResponseBody List<PageInfoBean> selectKcalActicleForIndex(
			HttpServletRequest request) {
		List<ArticleBean> result = new ArrayList<ArticleBean>();
		List<ArticleBean> newResult = new ArrayList<ArticleBean>();
		result = articleService.selectKcalActicleForIndex();
		int showArtcleCnt = 4;
		int addSpaceArtcleCnt = 0;
		for (int i = 0; result != null && i < result.size(); i++) {
			ArticleBean articleBean = new ArticleBean();
			String contents = result.get(i).getsContent();
			String picPath = Util.extracteContent(contents,
					request.getContextPath(), ".jpg", ".jpeg", ".bmp", ".png",
					".gif");
			if (contents.indexOf("<img") != -1) {
				contents = Util.deleteContent(contents, "<img", "\" />");
			}
			if (contents.indexOf("<") != -1) {
				contents = Util.deleteContent(contents, "<", ">");
			}
			articleBean.setdMakeTime(result.get(i).getdMakeTime());
			articleBean.setiArticleKind(result.get(i).getiArticleKind());
			articleBean.setsArticleId(result.get(i).getsArticleId());
			articleBean.setsTitle(result.get(i).getsTitle());
			articleBean.setsContent(contents.trim());
			if (picPath != null && picPath.length() > 0) {
				articleBean.setFilepath(picPath);
			} else {
				articleBean.setFilepath(result.get(i).getFilepath());
			}
			newResult.add(articleBean);
		}

		List<PageInfoBean> pageInfoList = new ArrayList<PageInfoBean>();
		if (newResult != null && newResult.size() > 0) {
			pageInfoList = formatIndexArticleList(newResult, 24, 80);
		}

		addSpaceArtcleCnt = showArtcleCnt - pageInfoList.size();
		Util util = new Util();
		for (int i = 0; i < addSpaceArtcleCnt; i++) {
			pageInfoList.add(util.makeSpacePageInfo());
		}
		return pageInfoList;
	}

	/**
	 * 查询首页图片库列表
	 * 
	 * @return
	 */
	@RequestMapping(params = "method=selectTpkForIndex", method = RequestMethod.POST)
	public @ResponseBody List<PageInfoBean> selectTpkForIndex() {
		List<FileBean> result = new ArrayList<FileBean>();
		result = articleService.selectTpkForIndex(0);
		int showArtcleCnt = 8;

		List<PageInfoBean> pageInfoList = new ArrayList<PageInfoBean>();
		for (int i = 0; i < showArtcleCnt; i++) {
			PageInfoBean pageInfo = new PageInfoBean();
			if (result != null && result.size() > i) {
				pageInfo.setArticleId(result.get(i).getFileId());
				pageInfo.setImg(result.get(i).getFilePath());
				pageInfo.setTitle(result.get(i).getFileName());
			} else {
				pageInfo.setArticleId("");
				pageInfo.setImg("");
				pageInfo.setTitle("");

			}
			pageInfoList.add(pageInfo);
		}
		return pageInfoList;
	}

	/**
	 * 查询首页扩展学习列表
	 * 
	 * @return
	 */
	@RequestMapping(params = "method=selectKzxxActicleForIndex", method = RequestMethod.POST)
	public @ResponseBody List<PageInfoBean> selectKzxxActicleForIndex(
			HttpServletRequest request) {
		List<ArticleBean> result = new ArrayList<ArticleBean>();
		List<ArticleBean> newResult = new ArrayList<ArticleBean>();
		result = articleService.selectKzxxActicleForIndex();
		int showArtcleCnt = 4;
		int addSpaceArtcleCnt = 0;
		for (int i = 0; result != null && i < result.size(); i++) {
			ArticleBean articleBean = new ArticleBean();
			String contents = result.get(i).getsContent();
			String picPath = Util.extracteContent(contents,
					request.getContextPath(), ".jpg", ".jpeg", ".bmp", ".png",
					".gif");
			if (contents.indexOf("<img") != -1) {
				contents = Util.deleteContent(contents, "<img", "\" />");
			}
			if (contents.indexOf("<") != -1) {
				contents = Util.deleteContent(contents, "<", ">");
			}
			articleBean.setdMakeTime(result.get(i).getdMakeTime());
			articleBean.setiArticleKind(result.get(i).getiArticleKind());
			articleBean.setsArticleId(result.get(i).getsArticleId());
			articleBean.setsTitle(result.get(i).getsTitle());
			articleBean.setsContent(contents.trim());
			if (picPath != null && picPath.length() > 0) {
				articleBean.setFilepath(picPath);
			} else {
				articleBean.setFilepath(result.get(i).getFilepath());
			}
			newResult.add(articleBean);
		}

		List<PageInfoBean> pageInfoList = new ArrayList<PageInfoBean>();
		if (newResult != null && newResult.size() > 0) {
			pageInfoList = formatIndexArticleList(newResult, 24, 80);
		}

		addSpaceArtcleCnt = showArtcleCnt - pageInfoList.size();
		Util util = new Util();
		for (int i = 0; i < addSpaceArtcleCnt; i++) {
			pageInfoList.add(util.makeSpacePageInfo());
		}
		return pageInfoList;
	}

	/**
	 * 查询首页动态图片
	 * 
	 * @return
	 */
	@RequestMapping(params = "method=selectDttpForIndex", method = RequestMethod.POST)
	public @ResponseBody List<PageInfoBean> selectDttpForIndex() {
		List<FileBean> result = new ArrayList<FileBean>();
		result = articleService.selectTpkForIndex(2);
		int showArtcleCnt = 7;
		List<PageInfoBean> pageInfoList = new ArrayList<PageInfoBean>();
		for (int i = 0; i < showArtcleCnt; i++) {
			PageInfoBean pageInfo = new PageInfoBean();
			if (result != null && result.size() > i) {
				pageInfo.setImg(result.get(i).getFilePath());
			} else {
				pageInfo.setImg("/STLVX_WEB/images/pictureNotFound.jpg");

			}
			pageInfoList.add(pageInfo);
		}
		return pageInfoList;
	}

	/**
	 * 做成首页显示用列表
	 * 
	 * @param showArticleList
	 * @return
	 */
	private List<PageInfoBean> formatIndexArticleList(
			List<ArticleBean> showArticleList, int titleLength, int briefLength) {
		List<PageInfoBean> result = new ArrayList<PageInfoBean>();
		SimpleDateFormat format = new SimpleDateFormat("MM-dd");
		Util util = new Util();
		for (ArticleBean bean : showArticleList) {
			PageInfoBean pageInfo = new PageInfoBean();
			pageInfo.setArticleId(bean.getsArticleId());
			pageInfo.setAuthor("");
			String title = bean.getsTitle();
			if (title == null) {
				title = "";
			}
			title = util.parse(title, titleLength);
			pageInfo.setTitle(title);
			String brief = bean.getsContent();
			if (brief == null) {
				brief = "";
			}
			if (briefLength == 0) {
				brief = "";
			}
			if (brief.length() > briefLength) {
				brief = brief.substring(0, briefLength - 1);
			}
			pageInfo.setBrief(brief);
			if (null != bean.getFilepath() && bean.getFilepath().length() > 0) {
				pageInfo.setImg(bean.getFilepath());
			} else {
				pageInfo.setImg("");
			}
			Date makeTime = bean.getdMakeTime();
			String strTime = format.format(makeTime);
			pageInfo.setTime(strTime);
			result.add(pageInfo);
		}
		return result;
	}
}

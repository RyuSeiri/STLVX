package com.syau.action;

import java.io.File;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.syau.constant.Constant;
import com.syau.po.AnserBean;
import com.syau.po.ArticleBean;
import com.syau.po.ArticleChapterBean;
import com.syau.po.ArticleChapterRelationBean;
import com.syau.po.ArticleFileAndViewBean;
import com.syau.po.ArticleFileBean;
import com.syau.po.ArticleFileChapterAndViewBean;
import com.syau.po.ArticleFileChapterBean;
import com.syau.po.ArticleFileOrderBean;
import com.syau.po.ArticleFileRelationBean;
import com.syau.po.ArticleOrderBean;
import com.syau.po.ArticleOverViewBean;
import com.syau.po.FileBean;
import com.syau.po.PraxisAnserBean;
import com.syau.po.PraxisBean;
import com.syau.po.QuestionReplyBean;
import com.syau.po.QuestionReplyPageInfoBean;
import com.syau.service.ArticleService;
import com.syau.util.Util;

@Controller
@RequestMapping("Article.do")
public class ArticleController {
	@Resource
	private ArticleService articleService;

	public ArticleService getArticleService() {
		return articleService;
	}

	public void setArticleService(ArticleService articleService) {
		this.articleService = articleService;
	}

	@Resource
	private ServletContext servletContext;

	public void setServletContext(ServletContext context) {
		this.servletContext = context;
	}

	/* ——————————————————————————电脑版调用的方法—————————————————————————— */
	/**
	 * 添加文章用
	 */
	@RequestMapping(params = "method=addArticle", method = RequestMethod.POST)
	public @ResponseBody String addArticle(String content, int kind,
			String title) throws Exception {
		String msg = "0";/* 用于返回给前台的message 1代表成功 、0代表失败 */
		if (content.indexOf(".mp4") >= 0) {
			content = Util.deleteContent(content, "<embed", "loop=\"true\" />");
		}
		/* 用于查询是否有该类型的文章存在有的话进行修改没有进行添加 */
		List<ArticleFileBean> list = articleService
				.selectArticleAndPicbykind(kind);
		if (list == null) {
			ArticleBean article = new ArticleBean();
			article.setsArticleId(System.currentTimeMillis() + "");
			article.setdMakeTime(new Timestamp(System.currentTimeMillis()));
			article.setiArticleKind(kind);
			article.setsContent(content);
			article.setsTitle(title);
			article.setsAuthorId("teacher");
			article.setDelFlg(Constant.FLG_NOT_DELETE);
			msg = articleService.addArticle(article);
		} else {
			ArticleFileBean bean = new ArticleFileBean();
			bean.setsArticleId(list.get(0).getsArticleId());
			bean.setsContent(content);
			bean.setsTitle(title);
			msg = articleService.saveOrUpdate(bean);
		}
		return msg;
	}

	/**
	 * 删除文章用
	 */
	@RequestMapping(params = "method=deleteByArticleId", method = RequestMethod.POST)
	public @ResponseBody String deleteByArticleId(String articleId) {
		String msg = articleService.deleteByArticleId(articleId);
		return msg;
	}

	/**
	 * 删除文章视频用
	 */
	@RequestMapping(params = "method=deleteVideoByArticleId", method = RequestMethod.POST)
	public @ResponseBody String deleteVideoByArticleId(String articleId) {
		String msg = articleService.deleteVideoByArticleId(articleId);
		return msg;
	}
	/**
	 * 用于删除互动教学的记录
	 */
	@RequestMapping(params = "method=deleteBycontentId", method = RequestMethod.POST)
	public @ResponseBody String deleteBycontentId(String contentId)
			throws Exception {

		String msg = articleService.deleteBycontentId(contentId);
		return msg;
	}

	@RequestMapping(params = "method=deleteByFileId", method = RequestMethod.POST)
	public @ResponseBody String deleteByFileId(String FileId) {
		String msg = articleService.deleteByFileId(FileId);
		return msg;
	}

	@RequestMapping(params = "method=selectActicle", method = RequestMethod.POST)
	public @ResponseBody List<ArticleBean> selectActicle() {
		List<ArticleBean> result = new ArrayList<ArticleBean>();
		result = articleService.selectNewArticle();
		return result;
	}

	/**
	 * 按文章类型查询（课程概况，课程大纲）
	 */
	@RequestMapping(params = "method=selectActicleByKind", method = RequestMethod.POST)
	public @ResponseBody List<ArticleFileBean> selectActicleByKind(int kind) {
		List<ArticleFileBean> result = new ArrayList<ArticleFileBean>();
		result = articleService.selectArticleAndPicbykind(kind);
		return result;
	}

	@RequestMapping(params = "method=selectFCActicleByKind", method = RequestMethod.POST)
	public @ResponseBody List<?> selectXIActicleByKind(
			String articleId) {
		List<ArticleFileChapterAndViewBean> result = articleService.selectArticleAndFiChaByid(articleId);
		return result;
	}

	@RequestMapping(params = "method=selectActicleChapter", method = RequestMethod.POST)
	public @ResponseBody List<?> selectActicleChapter() {
		List<ArticleChapterBean> result = new ArrayList<ArticleChapterBean>();
		result = articleService.selectActicleChapter();
		return result;
	}

	/**
	 * 更多授课视频
	 */
	@RequestMapping(params = "method=selectMorevideo", method = RequestMethod.POST)
	public @ResponseBody List<ArticleFileBean> selectMorevideo(int kind) {
		List<ArticleFileBean> result = new ArrayList<ArticleFileBean>();
		result = articleService.selectArticleAndAllFilebykind(kind);
		return result;
	}

	@RequestMapping(params = "method=selectActicleByid", method = RequestMethod.GET)
	public String selectActicleByid(@RequestParam String articleid,
			HttpServletRequest request, HttpSession session) throws Exception {
		List<ArticleFileAndViewBean> result =  articleService.selectArticleAndFileById(articleid, 1);
		if (result != null) {
			result.get(0).setArticleOverViews(result.get(0).getArticleOverViews()+1);
			ArticleOverViewBean bean =new ArticleOverViewBean();
			bean.setArticleOverViews(result.get(0).getArticleOverViews());
			bean.setsArticleId(articleid);
			articleService.saveOrUpdate(bean);
			request.setAttribute("result", result);
			String userName = (String) session.getAttribute("userName");
			if (null != userName && userName.length() > 0) {
				return "/Admin/CourseArticle";
			} else {
				return "/jsp/CourseArticle";
			}
		}
		return "404";
	}

	/**
	 * 更多理论教学文章
	 */
	@RequestMapping(params = "method=moreTheoryTeaching", method = RequestMethod.POST)
	public @ResponseBody List<ArticleBean> selectMoreTheoryArticle() {
		List<ArticleBean> result = new ArrayList<ArticleBean>();
		result = articleService.selectMoreTheoryArticle();
		return result;
	}

	@RequestMapping(params = "method=selectvideoByid", method = RequestMethod.GET)
	public String selectVideoDetail(String articleid,
			HttpServletRequest request, HttpSession session) throws Exception {
		List<ArticleFileAndViewBean> result =  articleService.selectArticleAndFileById(articleid, 1);
		if (result != null) {
			String filepath = result.get(0).getFilepath();
			result.get(0).setArticleOverViews(result.get(0).getArticleOverViews()+1);
			ArticleOverViewBean bean =new ArticleOverViewBean();
			bean.setArticleOverViews(result.get(0).getArticleOverViews());
			bean.setsArticleId(articleid);
			articleService.saveOrUpdate(bean);
			if (null != filepath && filepath.length() > 0) {
				File file = new File(servletContext.getRealPath("/").substring(
						0,
						servletContext.getRealPath("/").lastIndexOf(
								"\\STLVX_WEB\\"))
						+ filepath);
				if (file.exists()) {
					request.setAttribute("filepath", filepath);
				} else {
					request.setAttribute("filepath",
							"/STLVX_WEB/images/videoNotFound.jpg");
				}
			} else {
				request.setAttribute("filepath",
						"/STLVX_WEB/images/videoNotFound.jpg");
			}
			request.setAttribute("title", result.get(0).getsTitle());
			request.setAttribute("time", result.get(0).getdMakeTime());
			request.setAttribute("content", result.get(0).getsContent());
			request.setAttribute("overViews", result.get(0).getArticleOverViews());
			String userName = (String) session.getAttribute("userName");
			if (null != userName && userName.length() > 0) {
				return "/Admin/videoDetail";
			} else {
				return "/jsp/videoDetail";
			}
		}
		return "404";

	}

	@RequestMapping(params = "method=selectExercises", method = RequestMethod.POST)
	public @ResponseBody List<PraxisAnserBean> selectExercises(String articleid) {
		List<PraxisAnserBean> result = new ArrayList<PraxisAnserBean>();
		result = articleService.selectExercises(articleid);
		return result;
	}

	@RequestMapping(params = "method=selectEcProDeActicle", method = RequestMethod.POST)
	public @ResponseBody List<ArticleBean> selectEcProDeActicle() {
		List<ArticleBean> result = new ArrayList<ArticleBean>();
		result = articleService.selectEcProDeActicle();
		return result;
	}

	@RequestMapping(params = "method=selectCourseOverview", method = RequestMethod.POST)
	public @ResponseBody List<ArticleBean> selectCourseOverview() {
		List<ArticleBean> result = new ArrayList<ArticleBean>();
		result = articleService.selectCourseOverview();
		return result;
	}

	@RequestMapping(params = "method=selectCourseCase", method = RequestMethod.POST)
	public @ResponseBody List<ArticleFileBean> selectCourseCase(int kind,
			HttpServletRequest request) throws Exception {
		List<ArticleFileBean> result = new ArrayList<ArticleFileBean>();
		List<ArticleFileBean> list = new ArrayList<ArticleFileBean>();
		result = articleService.selectCourseCase(kind);
		if (result != null)
			for (int i = 0; i < result.size(); i++) {
				ArticleFileBean articleFileBean = new ArticleFileBean();
				String contents = result.get(i).getsContent();
				String picPath = Util.extracteContent(contents,
						request.getContextPath(), ".jpg", ".jpeg", ".bmp",".png",
						".gif");
				if (contents.indexOf("<img") != -1) {
					contents = Util.deleteContent(contents, "<img", "\" />");
				}
				if (contents.indexOf(".mp4") >= 0) {
					contents = Util.deleteContent(contents, "<embed",
							"loop=\"true\" />");
				}
				if (contents.indexOf("<") != -1) {
					contents = Util.deleteContent(contents, "<", ">");
				}
				articleFileBean.setsContent(contents.trim());
				if (picPath != null && picPath.length() > 0) {
					articleFileBean.setFilepath(picPath);
				} else {
					articleFileBean.setFilepath(result.get(i).getFilepath());
				}
				articleFileBean.setsArticleId(result.get(i).getsArticleId());
				articleFileBean.setsTitle(result.get(i).getsTitle());
				list.add(articleFileBean);
			}
		return list;
	}

	@RequestMapping(params = "method=selectArticleBykindAndChapterId", method = RequestMethod.POST)
	public @ResponseBody List<ArticleFileChapterBean> selectArticleBykindAndChapterId(
			int kind, String ChapterId, HttpServletRequest request)
			throws Exception {
		List<ArticleFileChapterBean> result = new ArrayList<ArticleFileChapterBean>();
		List<ArticleFileChapterBean> list = new ArrayList<ArticleFileChapterBean>();
		result = articleService.selectArticleAndFiChaByKind(kind, ChapterId);
		if (result != null)
			for (int i = 0; i < result.size(); i++) {
				ArticleFileChapterBean articleFileChapterBean = new ArticleFileChapterBean();
				String contents = result.get(i).getsContent();
				String picPath = Util.extracteContent(contents,
						request.getContextPath(), ".jpg", ".jpeg", ".bmp",".png",
						".gif");
				if (contents.indexOf("<img") != -1) {
					contents = Util.deleteContent(contents, "<img", "\" />");
				}
				// 用于删除视频路径
				if (contents.indexOf(".mp4") >= 0) {
					contents = Util.deleteContent(contents, "<embed",
							"loop=\"true\" />");
				}
				if (contents.indexOf("<") != -1) {
					contents = Util.deleteContent(contents, "<", ">");
				}
				articleFileChapterBean.setsContent(contents.trim());
				if (picPath != null && picPath.length() > 0) {
					articleFileChapterBean.setFilepath(picPath);
				} else {
					articleFileChapterBean.setFilepath(result.get(i)
							.getFilepath());
				}
				articleFileChapterBean.setsArticleId(result.get(i)
						.getsArticleId());
				articleFileChapterBean.setsTitle(result.get(i).getsTitle());
				articleFileChapterBean.setChapterInfo(result.get(i)
						.getChapterInfo());
				;
				articleFileChapterBean.setChapterId(result.get(i)
						.getChapterId());
				articleFileChapterBean.setdMakeTime(result.get(i)
						.getdMakeTime());
				list.add(articleFileChapterBean);
			}
		return list;
	}

	/**
	 * 理论教学文章的细节用
	 */
	@RequestMapping(params = "method=selectTheoryArticleBy", method = RequestMethod.POST)
	public @ResponseBody List<ArticleFileChapterBean> selectTheoryArticleBy(
			int kind, String ChapterId, HttpServletRequest request)
			throws Exception {
		List<ArticleFileChapterBean> result = new ArrayList<ArticleFileChapterBean>();
		result = articleService.selectArticleAndFiChaByKind(kind, ChapterId);
		return result;
	}

	@RequestMapping(params = "method=selectActicleDetailPicture", method = RequestMethod.GET)
	public String selectActicleDetailPicture(@RequestParam String articleid,
			HttpServletRequest request, HttpSession session) throws Exception {
		List<ArticleFileChapterAndViewBean> result = articleService
				.selectArticleAndFiChaByid(articleid);
		ArticleOverViewBean bean=new ArticleOverViewBean();
		if (result != null) {
			result.get(0).setArticleOverViews(result.get(0).getArticleOverViews()+1); 
			request.setAttribute("result", result);
			bean.setsArticleId(articleid);
			bean.setArticleOverViews(result.get(0).getArticleOverViews());
			articleService.saveOrUpdate(bean);
			String userName = (String) session.getAttribute("userName");
			if (null != userName && userName.length() > 0) {
				return "/Admin/ArticleDetail";
			} else {
				return "/jsp/ArticleDetail";
			}
		}
		return "404";
	}

	@RequestMapping(params = "method=selectCourseCaseVideo", method = RequestMethod.GET)
	public String selectCourseCaseVideo(String articleid,
			HttpServletRequest request, HttpSession session) throws Exception {
		List<ArticleFileAndViewBean> result = articleService.selectArticleAndFileById(articleid, 1);
		if (result != null) {
			result.get(0).setArticleOverViews(result.get(0).getArticleOverViews()+1);
			ArticleOverViewBean bean =new ArticleOverViewBean();
			bean.setArticleOverViews(result.get(0).getArticleOverViews());
			bean.setsArticleId(articleid);
			articleService.saveOrUpdate(bean);
			String filepath = result.get(0).getFilepath();
			if (null != filepath && filepath.length() > 0) {
				File file = new File(servletContext.getRealPath("/").substring(
						0,
						servletContext.getRealPath("/").lastIndexOf(
								"\\STLVX_WEB\\"))
						+ filepath);
				if (file.exists()) {
					request.setAttribute("filepath", filepath);
				} else {
					request.setAttribute("filepath",
							"/STLVX_WEB/images/videoNotFound.jpg");
				}
			} else {
				request.setAttribute("filepath",
						"/STLVX_WEB/images/videoNotFound.jpg");
			}
			request.setAttribute("content", result.get(0).getsContent());
			request.setAttribute("title", result.get(0).getsTitle());
			request.setAttribute("time", result.get(0).getdMakeTime());
			request.setAttribute("overViews", result.get(0).getArticleOverViews());
			String userName = (String) session.getAttribute("userName");
			if (null != userName && userName.length() > 0) {
				return "/Admin/videoDetail";
			} else {
				return "/jsp/videoDetail";
			}
		}
		return "404";
	}

	@RequestMapping(params = "method=selectCourseCasePicture", method = RequestMethod.GET)
	public String selectCourseCasePicture(@RequestParam String articleid,
			HttpServletRequest request, HttpSession session) throws Exception {
		List<ArticleFileAndViewBean> result = articleService.selectArticleAndFileById(articleid, 1);
		if (result != null) {
			result.get(0).setArticleOverViews(result.get(0).getArticleOverViews()+1);
			ArticleOverViewBean bean =new ArticleOverViewBean();
			bean.setArticleOverViews(result.get(0).getArticleOverViews());
			bean.setsArticleId(articleid);
			articleService.saveOrUpdate(bean);
			request.setAttribute("content", result.get(0).getsContent());
			request.setAttribute("title", result.get(0).getsTitle());
			request.setAttribute("time", result.get(0).getdMakeTime());
			request.setAttribute("overViews", result.get(0).getArticleOverViews());
			String userName = (String) session.getAttribute("userName");
			if (null != userName && userName.length() > 0) {
				return "/Admin/ArticleDetail";
			} else {
				return "/jsp/ArticleDetail";
			}
		}
		return "404";
	}

	/**
	 * 
	 * @param articleid
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(params = "method=selectEducationProgram", method = RequestMethod.GET)
	public String selectEducationProgram(@RequestParam String articleid,
			HttpServletRequest request, HttpSession session) throws Exception {
		List<ArticleFileAndViewBean> result = articleService.selectArticleAndFileById(articleid, 0);
		if (result != null) {
			result.get(0).setArticleOverViews(result.get(0).getArticleOverViews()+1);
			ArticleOverViewBean bean =new ArticleOverViewBean();
			bean.setArticleOverViews(result.get(0).getArticleOverViews());
			bean.setsArticleId(articleid);
			articleService.saveOrUpdate(bean);
			request.setAttribute("result", result);
			String userName = (String) session.getAttribute("userName");
			if (null != userName && userName.length() > 0) {
				return "/Admin/ArticleDetail";
			} else {
				return "/jsp/ArticleDetail";
			}
		}
		return "404";
	}

	@RequestMapping(params = "method=selectEducation", method = RequestMethod.POST)
	public @ResponseBody List<ArticleBean> selectEducation() {
		List<ArticleBean> result = new ArrayList<ArticleBean>();
		result = articleService.selectEducation();
		return result;
	}

	@RequestMapping(params = "method=selcetEnviroEducation", method = RequestMethod.POST)
	public @ResponseBody List<ArticleFileBean> selcetEnviroEducation(int kind) {
		List<ArticleFileBean> result = new ArrayList<ArticleFileBean>();
		result = articleService.selectArticleAndPicbykind(kind);
		return result;
	}

	@RequestMapping(params = "method=selectIndexPicDetail", method = RequestMethod.GET)
	public String selectIndexPicDetail(String fileId,
			HttpServletRequest request, HttpSession session) {
		List<FileBean> result = new ArrayList<FileBean>();
		result = articleService.selectFileDetailByFileId(fileId);
		if (result != null) {
			String filepath = result.get(0).getFilePath();
			if (null != filepath && filepath.length() > 0) {
				File file = new File(servletContext.getRealPath("/").substring(
						0,
						servletContext.getRealPath("/").lastIndexOf(
								"\\STLVX_WEB\\"))
						+ filepath);
				if (file.exists()) {
					request.setAttribute("filepath", filepath);
				} else {
					request.setAttribute("filepath",
							"/STLVX_WEB/images/pictureNotFound.jpg");
				}
			} else {
				request.setAttribute("filepath",
						"/STLVX_WEB/images/pictureNotFound.jpg");
			}
			String userName = (String) session.getAttribute("userName");
			if (null != userName && userName.length() > 0) {
				return "/Admin/PictureDetail";
			} else {
				return "/jsp/PictureDetail";
			}
		}
		return "404";
	}

	/**
	 * 
	 * @param articleid
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(params = "method=selectEcProDevideoByid", method = RequestMethod.GET)
	public String selectEcProDevideoByid(String articleid,
			HttpServletRequest request, HttpSession session) throws Exception {
		List<ArticleFileAndViewBean> result = articleService.selectArticleAndFileById(articleid, 1);
		if (result != null) {
			String filepath = result.get(0).getFilepath();
			result.get(0).setArticleOverViews(result.get(0).getArticleOverViews()+1);
			ArticleOverViewBean bean =new ArticleOverViewBean();
			bean.setArticleOverViews(result.get(0).getArticleOverViews());
			bean.setsArticleId(articleid);
			articleService.saveOrUpdate(bean);
			if (null != filepath && filepath.length() > 0) {
				File file = new File(servletContext.getRealPath("/").substring(
						0,
						servletContext.getRealPath("/").lastIndexOf(
								"\\STLVX_WEB\\"))
						+ filepath);
				if (file.exists()) {
					request.setAttribute("filepath", filepath);
				} else {
					request.setAttribute("filepath",
							"/STLVX_WEB/images/videoNotFound.jpg");
				}
			} else {
				request.setAttribute("filepath",
						"/STLVX_WEB/images/videoNotFound.jpg");
			}
			request.setAttribute("title", result.get(0).getsTitle());
			request.setAttribute("content", result.get(0).getsContent());
			request.setAttribute("time", result.get(0).getdMakeTime());
			request.setAttribute("overViews", result.get(0).getArticleOverViews());
			String userName = (String) session.getAttribute("userName");
			if (null != userName && userName.length() > 0) {
				return "/Admin/videoDetail";
			} else {
				return "/jsp/videoDetail";
			}
		}
		return "404";
	}

	/**
	 * 课程案例用于判断该文章是否含有视频, 有就跳到视频的详情页面没有就跳到普通的页面.
	 * @throws Exception 例外
	 */
	@RequestMapping(params = "method=selectIndexCourseCase", method = RequestMethod.GET)
	public String selectIndexCourseCase(@RequestParam String articleid,
			HttpServletRequest request, HttpSession session) throws Exception {
		List<ArticleFileAndViewBean> result = new ArrayList<ArticleFileAndViewBean>();
		result = articleService.selectArticleAndFileById(articleid, 1);
		if (result != null) {
			result.get(0).setArticleOverViews(result.get(0).getArticleOverViews()+1);
			ArticleOverViewBean bean =new ArticleOverViewBean();
			bean.setArticleOverViews(result.get(0).getArticleOverViews());
			bean.setsArticleId(articleid);
			articleService.saveOrUpdate(bean);
			String filepath = result.get(0).getFilepath();
			if (filepath == null || filepath.length() <= 0) {
				request.setAttribute("result", result);
				String userName = (String) session.getAttribute("userName");
				if (null != userName && userName.length() > 0) {
					return "/Admin/ArticleDetail";
				} else {
					return "/jsp/ArticleDetail";
				}
			} else {
				File file = new File(servletContext.getRealPath("/").substring(0,
						servletContext.getRealPath("/").lastIndexOf(
								"\\STLVX_WEB\\"))
						+ filepath);
				if (file.exists()) {
					request.setAttribute("filepath", filepath);
				} else {
					request.setAttribute("filepath",
							"/STLVX_WEB/images/videoNotFound.jpg");
				}
				request.setAttribute("title", result.get(0).getsTitle());
				request.setAttribute("content", result.get(0).getsContent());
				request.setAttribute("time", result.get(0).getdMakeTime());
				request.setAttribute("overViews", result.get(0).getArticleOverViews());
				String userName = (String) session.getAttribute("userName");
				if (null != userName && userName.length() > 0) {
					return "/Admin/videoDetail";
				} else {
					return "/jsp/videoDetail";
				}
			}
		}
		return "404";
	}

	/**
	 * @param orderFlg
	 *            排序FLG
	 */
	@RequestMapping(params = "method=selectTheoryTeachingArticle", method = RequestMethod.POST)
	public @ResponseBody List<ArticleFileBean> selectTheoryTeachingArticle(
			String orderFlg) {
		List<ArticleFileBean> result = new ArrayList<ArticleFileBean>();
		if (null != orderFlg && orderFlg.length() > 0) {
			result = articleService.selectTheoryTeachingArticle(orderFlg);
		} else {
			result = articleService.selectTheoryTeachingArticle();
		}
		return result;
	}

	/**
	 * 查询理论教学文章列表（首页用）
	 */
	@RequestMapping(params = "method=selectLljxActicleForIndex", method = RequestMethod.POST)
	public @ResponseBody List<ArticleBean> selectLljxActicleForIndex() {
		List<ArticleBean> result = new ArrayList<ArticleBean>();
		result = articleService.selectLljxActicleForIndex();
		return result;
	}

	/**
	 * 查询习题用
	 */
	@RequestMapping(params = "method=selectExercises", method = RequestMethod.GET)
	public String selectExercises(@RequestParam String articleid,
			HttpServletRequest request, HttpSession session) {
		List<PraxisAnserBean> result = new ArrayList<PraxisAnserBean>();
		result = articleService.selectExercises(articleid);
		if (result != null) {
			request.setAttribute("result", result);
			String userName = (String) session.getAttribute("userName");
			if (null != userName && userName.length() > 0) {
				return "/Admin/PraxisAnser";
			} else {
				return "/jsp/PraxisAnser";
			}
		}
		return "404";
	}

	/**
	 * 查询学生的提问
	 */
	@RequestMapping(params = "method=selectQuestionAndReply", method = RequestMethod.POST)
	public @ResponseBody List<QuestionReplyPageInfoBean> selectQuestionAndReply(
			HttpServletRequest request, int page) {
		List<QuestionReplyBean> query = new ArrayList<QuestionReplyBean>();
		List<QuestionReplyPageInfoBean> result = new ArrayList<QuestionReplyPageInfoBean>();
		query = articleService.selectQuestionAndReply();
		/* 获取总的页数 */
		int totlePage = 0;
		if (null != query && query.size() > 0) {
			totlePage = Util.getPageCount(query.size());
			Util.setListResult(page, query, result, totlePage);
		}
		return result;
	}

	/**
	 * 用于页面取总的页面用
	 */
	@RequestMapping(params = "method=selectPageCount", method = RequestMethod.POST)
	public @ResponseBody int selectPageCount(HttpServletRequest request) {
		List<QuestionReplyBean> query = articleService.selectQuestionAndReply();
		//DB中有记录的情况显示实际的页数
		if(query!=null)
		return Util.getPageCount(query.size());
		//其他情况返回总页数1页
		return 1;
	}

	/**
	 * 学生提问用
	 */
	@RequestMapping(params = "method=addQuestion", method = RequestMethod.POST)
	public String addQuestion(
			@RequestParam(value = "contents") String contents,
			HttpServletRequest request) throws Exception {
		QuestionReplyBean question = new QuestionReplyBean();
		question.setDelFlg(Constant.FLG_NOT_DELETE);
		question.setContent(contents);
		question.setTime(new Date());
		question.setContentId(Long.toString(new Date().getTime()));
		question.setContentType(0);
		try {
			articleService.addQuestionAndReply(question);
			// request.setAttribute("msg", "提问成功！");
		} catch (Exception e) {
			request.setAttribute("msg", "提问失败请稍后再试！");
		}
		return "/jsp/Question";
	}

	/**
	 * 老师回答用
	 */
	@RequestMapping(params = "method=addReply", method = RequestMethod.POST)
	public String addReply(@RequestParam(value = "contents") String contents,
			HttpServletRequest request) throws Exception {
		QuestionReplyBean Reply = new QuestionReplyBean();
		Reply.setDelFlg(Constant.FLG_NOT_DELETE);
		Reply.setContent(contents);
		Reply.setTime(new Date());
		Reply.setContentId(Long.toString(new Date().getTime()));
		Reply.setContentType(1);
		try {
			articleService.addQuestionAndReply(Reply);
			// request.setAttribute("msg", "提问成功！");
		} catch (Exception e) {
			request.setAttribute("msg", "提问失败请稍后再试！");
		}
		return "/Admin/Question";
	}

	/**
	 * 选择所有在线测试用
	 */

	@RequestMapping(params = "method=selectAllOnlineTest", method = RequestMethod.POST)
	public @ResponseBody List<ArticleBean> selectAllOnlineTest(
			@RequestParam int kind, String ChapterId) {
		List<ArticleBean> result = new ArrayList<ArticleBean>();
		result = articleService.selectOnlineTest(kind, ChapterId);
		return result;
	}

	/**
	 * 查询在线测试用
	 */
	@RequestMapping(params = "method=selectOnlineTest", method = RequestMethod.GET)
	public String selectOnlineTest(@RequestParam String articleid,
			HttpServletRequest request, HttpSession session) {
		List<PraxisAnserBean> result = new ArrayList<PraxisAnserBean>();
		result = articleService.selectExercises(articleid);
		if (result != null) {
			String[] onlineTestCount = result.get(0).getAnswerInfo()
					.split(",|，|、");
			request.setAttribute("onlineTestCount", onlineTestCount.length);
			request.setAttribute("result", result);
			String userName = (String) session.getAttribute("userName");
			if (null != userName && userName.length() > 0) {
				return "/Admin/OnlineTestDetail";
			} else {
				return "/jsp/OnlineTestDetail";
			}
		}
		return "404";
	}

	/**
	 * 在线测判分用
	 */
	@RequestMapping(params = "method=judgePaper", method = RequestMethod.POST)
	public String judgePaper(@RequestParam String articleid,
			HttpServletRequest request, int onlineTestCount, HttpSession session) {
		/* 答对问题的数量 */
		Double count = 0.00;
		List<PraxisAnserBean> result = new ArrayList<PraxisAnserBean>();
		result = articleService.selectExercises(articleid);
		/* 真正的答案 */
		String realAnswer = "";
		if (result.get(0).getAnswerInfo() != null
				&& result.get(0).getAnswerInfo().trim().length() > 0)
			realAnswer = result.get(0).getAnswerInfo().trim()
					.replaceAll(" ", "");

		/* 根据问题的个数计算出每个问题的分值 */
		Double point = (100.0 / onlineTestCount);
		/* 如果没有答案就跳到404 */
		if (null == realAnswer || realAnswer.length() <= 0)
			return "404";

		/* 把答案集合变成数组 */
		String[] answerArray = realAnswer.split(",|，|、");
		/* 判断学生的答案 */
		for (int i = 0; i < answerArray.length; i++) {
			/* 取得学生的答案 */
			String[] stuAnswers = request
					.getParameterValues("answer" + (i + 1));
			StringBuffer sb = new StringBuffer();
			if (stuAnswers != null && stuAnswers.length > 0)
				for (int j = 0; j < stuAnswers.length; j++) {
					sb.append(stuAnswers[j]);
				}

			String strStuAnswer = sb.toString();
			if (((String) answerArray[i]).equalsIgnoreCase(strStuAnswer)) {
				// System.out.println("全对了");
				count++;
			}/*
			 * else if(answerArray[i].toUpperCase().contains(strStuAnswer)){
			 * //System.out.println("对了一半"); count+=0.5; }
			 */
		}
		request.setAttribute("answerArray", answerArray);
		/* 理论上学生应该得到的分数 */
		Double finalPoint = point * count;
		/* 实际上学生应该得到的分数 */
		if (finalPoint != 0.0) {
			request.setAttribute(
					"point",
					finalPoint.toString().substring(0,
							finalPoint.toString().indexOf(".") + 2));
		} else {
			request.setAttribute("point", 0);
		}
		/* 跳转到的分数详情页 */
		String userName = (String) session.getAttribute("userName");
		if (null != userName && userName.length() > 0) {
			return "/Admin/OnlineTestPoint";
		} else {
			return "/jsp/OnlineTestPoint";
		}

	}

	/**
	 * 课程后台编辑用
	 */
	@RequestMapping(params = "method=editerByKind", method = RequestMethod.POST)
	public @ResponseBody List<ArticleFileBean> editerByKind(int kind) {
		List<ArticleFileBean> result = new ArrayList<ArticleFileBean>();
		result = articleService.selectArticleAndPicbykind(kind);
		return result;
	}

	/**
	 * 选择要编辑的文章
	 */
	@RequestMapping(params = "method=selectEditerArticle", method = RequestMethod.GET)
	public String selectEditerArticle(@RequestParam String articleid,
			HttpServletRequest request, HttpSession session) {
		List<ArticleFileAndViewBean> result = articleService.selectArticleAndFileById(
				articleid, 1);
		if (result != null)
			request.setAttribute("result", result);
		String userName = (String) session.getAttribute("userName");
		if (null != userName && userName.length() > 0)
			return "/Admin/ArticleEdit";

		return "redirect:login/ManagerLogin.jsp";
	}

	@RequestMapping(params = "method=selectEditerTheory", method = RequestMethod.GET)
	public String selectEditerTheory(@RequestParam String articleid,
			HttpServletRequest request, HttpSession session) throws Exception {
		List<ArticleFileOrderBean> result = articleService.selectEditerTheory(
				articleid, 1);
		if (result != null)
			request.setAttribute("result", result);
		String userName = (String) session.getAttribute("userName");
		if (null != userName && userName.length() > 0)
			return "/Admin/editTheoryTeaching";

		return "redirect:login/ManagerLogin.jsp";
	}

	/**
	 * 选择要变得在线测试的文章
	 */
	@RequestMapping(params = "method=selectEditerOnlineTest", method = RequestMethod.GET)
	public String selectEditerOnlineTest(@RequestParam String articleid,
			HttpServletRequest request, HttpSession session) {
		List<PraxisAnserBean> result = new ArrayList<PraxisAnserBean>();
		result = articleService.selectExercises(articleid);
		if (result != null)
			request.setAttribute("result", result);
		String userName = (String) session.getAttribute("userName");
		if (null != userName && userName.length() > 0)
			return "/Admin/OnlineTestEdit";

		return "redirect:login/ManagerLogin.jsp";
	}

	/**
	 * 详细文章的编辑用（添加或者修改视频）
	 */
	@RequestMapping(params = "method=editerDetialArticle", method = RequestMethod.POST)
	public @ResponseBody String editerDetialArticle(String content,
			String articleid, String title, HttpServletRequest request)
			throws Exception {
		String msg = "0";/* 用于返回给前台的message 1代表更新成功 、0代表更新失败 */
		String videoPath = "";/* 视频的路径 */
		String picPath = "";/* 视频略缩图的路径 */
		if (articleid == null || "".equals(articleid.trim())) {
			articleid = System.currentTimeMillis() + "";
		}
		if (content.indexOf(".mp4") >= 0) {
			videoPath = Util.extracteContent(content, request.getContextPath(),
					".mp4");
			picPath = videoPath.replace(".mp4", ".jpg");
			content = Util.deleteContent(content, "<embed", "loop=\"true\" />");
			/* 视频 */
			FileBean fileVideo = new FileBean();
			fileVideo.setFileId(articleid);
			fileVideo.setFileName("视频");
			fileVideo.setFilePath(videoPath);
			fileVideo.setFileType(Constant.FILETYPE_VIDEO);
			fileVideo.setDelflg(Constant.FLG_NOT_DELETE);
			/* 视频的文件关系表 */
			ArticleFileRelationBean videoRelation = new ArticleFileRelationBean();
			videoRelation.setFileId(articleid);
			videoRelation.setsArticleId(articleid);
			/* 视频的略缩图 */
			FileBean filePicture = new FileBean();
			/* 文章文件关系表 */
			ArticleFileRelationBean picRelation = new ArticleFileRelationBean();
			List<FileBean> result = articleService.selectFileExsit(articleid);
			if (null != result && null != result.get(0).getFilePath()
					&& result.get(0).getFilePath().length() > 0
					&& result.size() > 1) {
				filePicture.setFileId(result.get(1).getFileId());
				filePicture.setFilePath(picPath);
				filePicture.setDelflg(Constant.FLG_NOT_DELETE);
				picRelation.setsArticleId(articleid);
				picRelation.setFileId(result.get(1).getFileId());
			} else {
				String fileId = System.currentTimeMillis()
						+ (int) (Math.random() * 1000) + "";
				filePicture.setFileId(fileId);
				filePicture.setFileName("视频略缩图");
				filePicture.setFilePath(picPath);
				filePicture.setFileType(Constant.FILETYPE_PICTURE);
				filePicture.setDelflg(Constant.FLG_NOT_DELETE);
				picRelation.setFileId(fileId);
				picRelation.setsArticleId(articleid);
			}
			msg = articleService.saveOrUpdate(fileVideo, videoRelation,
					filePicture, picRelation);
			if (msg.equals("0"))
				return msg;

		}
		ArticleBean bean = new ArticleBean();
		List<ArticleBean> acticle = articleService.selectActicleById(articleid);
		if (acticle == null) {
			bean.setsArticleId(articleid);
			bean.setsContent(content);
			bean.setsTitle(title);
			bean.setsAuthorId("teacher");
			bean.setdMakeTime(new Timestamp(System.currentTimeMillis()));
			bean.setiArticleKind(Constant.PRODUCT_DESIGN_REQUIREMENTS);
		} else {
			bean = acticle.get(0);
			bean.setsContent(content);
			bean.setsTitle(title);
		}

		msg = articleService.saveOrUpdate(bean);
		return msg;
	}

	/**
	 * 添加文章的通用方法
	 * 
	 * @throws Exception
	 */
	@RequestMapping(params = "method=addDetaileArticle", method = RequestMethod.POST)
	public @ResponseBody String addDetaileArticle(String content, int kind,
			String title, HttpServletRequest request) throws Exception {
		String result = "";
		String videoPath = "";/* 视频的路径 */
		String picPath = "";/* 视频略缩图的路径 */
		String articleid = System.currentTimeMillis() + "";/* 文章的Id */
		if (content.indexOf(".mp4") >= 0) {
			videoPath = Util.extracteContent(content, request.getContextPath(),
					".mp4");
			picPath = videoPath.replace(".mp4", ".jpg");
			content = Util.deleteContent(content, "<embed", "loop=\"true\" />");
			/* 视频 */
			FileBean fileVideo = new FileBean();
			fileVideo.setFileId(articleid);
			fileVideo.setFileName("视频");
			fileVideo.setFilePath(videoPath);
			fileVideo.setFileType(Constant.FILETYPE_VIDEO);
			fileVideo.setDelflg(Constant.FLG_NOT_DELETE);
			/* 视频的文件关系表 */
			ArticleFileRelationBean videoRelation = new ArticleFileRelationBean();
			videoRelation.setFileId(articleid);
			videoRelation.setsArticleId(articleid);
			/* 视频的略缩图 */
			FileBean filePicture = new FileBean();
			String fileId = System.currentTimeMillis()
					+ (int) (Math.random() * 1000) + "";/* 文件的ID */
			filePicture.setFileId(fileId);
			filePicture.setFileName("视频略缩图");
			filePicture.setFilePath(picPath);
			filePicture.setFileType(Constant.FILETYPE_PICTURE);
			filePicture.setDelflg(Constant.FLG_NOT_DELETE);
			/* 文章文件关系表 */
			ArticleFileRelationBean picRelation = new ArticleFileRelationBean();
			picRelation.setFileId(fileId);
			picRelation.setsArticleId(articleid);
			articleService.addEntity(fileVideo, videoRelation, filePicture,
					picRelation);
		}
		/* 文章的实体类 */
		ArticleBean article = new ArticleBean();
		article.setsArticleId(articleid);
		article.setdMakeTime(new Timestamp(System.currentTimeMillis()));
		article.setiArticleKind(kind);
		article.setsContent(content);
		article.setsTitle(title);
		article.setsAuthorId("teacher");
		article.setDelFlg(Constant.FLG_NOT_DELETE);
		result = articleService.addEntity(article);
		return result;
	}

	/**
	 * 添加理论教学文章的用
	 */
	@RequestMapping(params = "method=addTheoryTeachingArticle", method = RequestMethod.POST)
	public @ResponseBody String addTheoryTeachingArticle(String content,
			String chapterId, int kind, String title, String order,
			HttpServletRequest request) throws Exception {
		String msg = "0";
		String videoPath = "";/* 视频的路径 */
		String picPath = "";/* 视频略缩图的路径 */
		String articleid = System.currentTimeMillis() + "";/* 文章的Id */
		if (content.indexOf(".mp4") >= 0) {
			videoPath = Util.extracteContent(content, request.getContextPath(),
					".mp4");
			picPath = videoPath.replace(".mp4", ".jpg");
			content = Util.deleteContent(content, "<embed", "loop=\"true\" />");
			/* 视频 */
			FileBean fileVideo = new FileBean();
			fileVideo.setFileId(articleid);
			fileVideo.setFileName("视频");
			fileVideo.setFilePath(videoPath);
			fileVideo.setFileType(Constant.FILETYPE_VIDEO);
			fileVideo.setDelflg(Constant.FLG_NOT_DELETE);
			/* 视频的文件关系表 */
			ArticleFileRelationBean videoRelation = new ArticleFileRelationBean();
			videoRelation.setFileId(articleid);
			videoRelation.setsArticleId(articleid);
			/* 视频的略缩图 */
			FileBean filePicture = new FileBean();
			String fileId = System.currentTimeMillis()
					+ (int) (Math.random() * 1000) + "";/* 文件的ID */
			filePicture.setFileId(fileId);
			filePicture.setFileName("视频略缩图");
			filePicture.setFilePath(picPath);
			filePicture.setFileType(Constant.FILETYPE_PICTURE);
			filePicture.setDelflg(Constant.FLG_NOT_DELETE);
			/* 文章文件关系表 */
			ArticleFileRelationBean picRelation = new ArticleFileRelationBean();
			picRelation.setFileId(fileId);
			picRelation.setsArticleId(articleid);
			articleService.addEntity(fileVideo, videoRelation, filePicture,
					picRelation);
		}
		/* 文章的实体类 */
		ArticleBean article = new ArticleBean();
		article.setsArticleId(articleid);
		article.setdMakeTime(new Timestamp(System.currentTimeMillis()));
		article.setiArticleKind(kind);
		article.setsContent(content);
		article.setsTitle(title);
		article.setsAuthorId("teacher");
		article.setDelFlg(Constant.FLG_NOT_DELETE);
		ArticleOrderBean articleOrderBean = new ArticleOrderBean();
		if (order != null && order.trim().length() > 0) {
			articleOrderBean
					.setOrderInfo(new Integer(order.replaceAll(" ", "")));
		} else {
			articleOrderBean.setOrderInfo(99);
		}
		/* 文章关联实体类 */
		ArticleChapterRelationBean chapterBean = new ArticleChapterRelationBean();
		chapterBean.setChapterId(chapterId);
		chapterBean.setsArticleId(articleid);
		articleOrderBean.setsArticleId(articleid);
		msg = articleService.addEntity(article, articleOrderBean, chapterBean);
		return msg;
	}

	@RequestMapping(params = "method=addDynamicPicture", method = RequestMethod.POST)
	public @ResponseBody String addDynamicPicture(String content,
			HttpServletRequest request) throws Exception {
		String msg = "0";
		String picPath = "";/* 视频略缩图的路径 */
		String fileId = System.currentTimeMillis()
				+ (int) (Math.random() * 1000) + "";/* 文件的Id */
		if (content.indexOf(".mp4") != -1) {
			content = Util.deleteContent(content, "<embed", "loop=\"true\" />");
		}
		picPath = Util.extracteContent(content,
				request.getContextPath(), ".jpg", ".jpeg", ".bmp",".png",
				".gif");
		FileBean fileBean = new FileBean();
		fileBean.setDelflg(Constant.FLG_NOT_DELETE);
		fileBean.setFileId(fileId);
		fileBean.setFileName("首页动态图片");
		fileBean.setFilePath(picPath);
		fileBean.setFileType(Constant.FILETYPE_HEADER_PICTURE);
		msg = articleService.addEntity(fileBean);
		return msg;
	}

	@RequestMapping(params = "method=selectDeleteDynamicPicture", method = RequestMethod.GET)
	public String selectDeleteDynamicPicture(HttpServletRequest request) {
		List<FileBean> result = new ArrayList<FileBean>();
		result = articleService.selectTpkForIndex(2);
		request.setAttribute("result", result);
		return "Admin/deleteDynamicPicture";
	}

	@RequestMapping(params = "method=addArticleAndChapter", method = RequestMethod.POST)
	public @ResponseBody String addArticleAndChapter(String content, int kind,
			String title, @RequestParam(value = "chapter") String chapterId,
			HttpServletRequest request) throws Exception {
		String msg = "0";/* message */
		String articleId = System.currentTimeMillis() + "";/* 文章的Id */
		if (content.indexOf(".mp4") >= 0) {
			content = Util.deleteContent(content, "<embed", "loop=\"true\" />");
		}
		/* 文章的实体类 */
		ArticleBean article = new ArticleBean();
		article.setsArticleId(articleId);
		article.setdMakeTime(new Timestamp(System.currentTimeMillis()));
		article.setiArticleKind(kind);
		article.setsContent(content);
		article.setsTitle(title);
		article.setsAuthorId("teacher");
		article.setDelFlg(Constant.FLG_NOT_DELETE);
		/* 文章关联实体类 */
		ArticleChapterRelationBean chapterBean = new ArticleChapterRelationBean();
		chapterBean.setChapterId(chapterId);
		chapterBean.setsArticleId(articleId);
		msg = articleService.addEntity(article, chapterBean);
		return msg;
	}

	@RequestMapping(params = "method=editTheoryTeaching", method = RequestMethod.POST)
	public @ResponseBody String editTheoryTeaching(String content,
			String articleid, String title, int order,
			HttpServletRequest request) throws Exception {
		String msg = "0";/* 用于返回给前台的message 1代表更新成功 、0代表更新失败 */
		String videoPath = "";/* 视频的路径 */
		String picPath = "";/* 视频略缩图的路径 */
		if (articleid == null || "".equals(articleid.trim())) {
			articleid = System.currentTimeMillis() + "";
		}
		if (content.indexOf(".mp4") >= 0) {
			videoPath = Util.extracteContent(content, request.getContextPath(),
					".mp4");
			picPath = videoPath.replace(".mp4", ".jpg");
			content = Util.deleteContent(content, "<embed", "loop=\"true\" />");
			/* 视频 */
			FileBean fileVideo = new FileBean();
			fileVideo.setFileId(articleid);
			fileVideo.setFileName("视频");
			fileVideo.setFilePath(videoPath);
			fileVideo.setFileType(Constant.FILETYPE_VIDEO);
			fileVideo.setDelflg(Constant.FLG_NOT_DELETE);
			/* 视频的文件关系表 */
			ArticleFileRelationBean videoRelation = new ArticleFileRelationBean();
			videoRelation.setFileId(articleid);
			videoRelation.setsArticleId(articleid);
			/* 视频的略缩图 */
			FileBean filePicture = new FileBean();
			/* 文章文件关系表 */
			ArticleFileRelationBean picRelation = new ArticleFileRelationBean();
			List<FileBean> result = articleService.selectFileExsit(articleid);
			if (null != result && null != result.get(0).getFilePath()
					&& result.get(0).getFilePath().length() > 0
					&& result.size() > 1) {
				filePicture.setFileId(result.get(1).getFileId());
				filePicture.setFilePath(picPath);
				filePicture.setDelflg(Constant.FLG_NOT_DELETE);
				picRelation.setsArticleId(articleid);
				picRelation.setFileId(result.get(1).getFileId());
			} else {
				String fileId = System.currentTimeMillis()
						+ (int) (Math.random() * 1000) + "";
				filePicture.setFileId(fileId);
				filePicture.setFileName("视频略缩图");
				filePicture.setFilePath(picPath);
				filePicture.setFileType(Constant.FILETYPE_PICTURE);
				filePicture.setDelflg(Constant.FLG_NOT_DELETE);
				picRelation.setFileId(fileId);
				picRelation.setsArticleId(articleid);
			}
			msg = articleService.saveOrUpdate(fileVideo, videoRelation,
					filePicture, picRelation);
			if (msg.equals("0"))
				return msg;

		}
		ArticleFileBean bean = new ArticleFileBean();
		bean.setsArticleId(articleid);
		bean.setsContent(content);
		bean.setsTitle(title);
		ArticleOrderBean articleOrderBean = new ArticleOrderBean();
		articleOrderBean.setOrderInfo(order);
		articleOrderBean.setsArticleId(articleid);
		msg = articleService.saveOrUpdate(bean, articleOrderBean);
		return msg;
	}

	@RequestMapping(params = "method=addChapter", method = RequestMethod.POST)
	public @ResponseBody String addChapter(
			@RequestParam(value = "chapter") String chapterId,
			String chapterContent) throws Exception {
		List<ArticleChapterBean> chapter = new ArrayList<ArticleChapterBean>();
		chapter = articleService.selectActicleChapter();
		String msg = "0";/* 用于返回给前台的message 1代表更新成功 、0代表更新失败 */
		if (chapter != null) {
			for (int i = 0; i < chapter.size(); i++) {
				if (chapterId.equals(chapter.get(i).getChapterid())) {
					return "3";/* 该文章已经存在,请重新选择! */
				}
			}
		}
		ArticleChapterBean newChapter = new ArticleChapterBean();
		newChapter.setChapterid(chapterId);
		newChapter.setDel_flg(0);
		if (chapterContent == null || "".equals(chapterContent)) {
			Integer Id = new Integer(chapterId);
			newChapter.setChapterinfo(ArticleChapterBean
					.getChapterTitle(Id - 1));
		} else {
			newChapter.setChapterinfo(chapterContent);
		}
		msg = articleService.addEntity(newChapter);
		return msg;
	}

	/**
	 * 删除文章的章节用
	 */
	@RequestMapping(params = "method=deleteChapter", method = RequestMethod.POST)
	public @ResponseBody String deleteChapter(String chapterId)
			throws Exception {
		String msg = "0";/* 用于返回给前台的message 1代表更新成功 、0代表更新失败 */
		ArticleChapterBean chapter = new ArticleChapterBean();
		chapter.setChapterid(chapterId);
		msg = articleService.deleteChapter(chapter);
		return msg;
	}

	/**
	 * 
	 * @param content 在线测试的内容
	 * @param answer 答案
	 * @param title 标题
	 * @param chapterId 章节的
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(params = "method=addOnlineTest", method = RequestMethod.POST)
	public @ResponseBody String addOnlineTest(/* String questionCount, */
	String content, String answer, String title, String chapterId,
			HttpServletRequest request) throws Exception {
		String msg = "0";/* 用于返回给前台的message 1代表更新成功 、0代表更新失败 */
		String articleId = System.currentTimeMillis() + "";/* 文章的Id */
		if (content.indexOf(".mp4") >= 0) {
			content = Util.deleteContent(content, "<embed", "loop=\"true\" />");
		}
		/* 文章的实体类 */
		ArticleBean article = new ArticleBean();
		article.setsArticleId(articleId);
		article.setdMakeTime(new Timestamp(System.currentTimeMillis()));
		article.setiArticleKind(Constant.ONLINE_TEST);
		article.setsContent(chapterId);
		article.setsTitle(title);
		article.setsAuthorId("teacher");
		article.setDelFlg(Constant.FLG_NOT_DELETE);
		/* 习题实体类 */
		PraxisBean praxisBean = new PraxisBean();
		praxisBean.setDelFlg(0);
		praxisBean.setPraxisId(articleId);
		praxisBean.setPraxisInfo(content);
		/* 答案的实体类 */
		AnserBean anserBean = new AnserBean();
		anserBean.setAnswerId(articleId);
		anserBean.setAnswerInfo(answer);
		anserBean.setDel_flg(Constant.FLG_NOT_DELETE);
		msg = articleService.addEntity(article, praxisBean, anserBean);
		return msg;
	}

	@RequestMapping(params = "method=addPraxis", method = RequestMethod.POST)
	public @ResponseBody String addPraxis(String content, String answer,
			String title, String chapterId, HttpServletRequest request)
			throws Exception {
		String msg = "0";/* 用于返回给前台的message 1代表更新成功 、0代表更新失败 */
		String articleId = System.currentTimeMillis() + "";/* 文章的Id */
		if (content.indexOf(".mp4") >= 0) {
			content = Util.deleteContent(content, "<embed", "loop=\"true\" />");
		}
		/* 文章的实体类 */
		ArticleBean article = new ArticleBean();
		article.setsArticleId(articleId);
		article.setdMakeTime(new Timestamp(System.currentTimeMillis()));
		article.setiArticleKind(Constant.EXERCISES);
		article.setsContent(content);
		article.setsTitle(title);
		article.setsAuthorId("teacher");
		article.setDelFlg(Constant.FLG_NOT_DELETE);
		/* 文章关联实体类 */
		ArticleChapterRelationBean chapterBean = new ArticleChapterRelationBean();
		chapterBean.setChapterId(chapterId);
		chapterBean.setsArticleId(articleId);
		/* 习题实体类 */
		PraxisBean praxisBean = new PraxisBean();
		praxisBean.setDelFlg(0);
		praxisBean.setPraxisId(articleId);
		praxisBean.setPraxisInfo("");
		/* 答案的实体类 */
		AnserBean anserBean = new AnserBean();
		anserBean.setAnswerId(articleId);
		anserBean.setAnswerInfo(answer);
		anserBean.setDel_flg(Constant.FLG_NOT_DELETE);
		msg = articleService.addEntity(article, chapterBean, praxisBean,
				anserBean);
		return msg;
	}

	/**
	 * 用于编辑改修在线测试用
	 */
	@RequestMapping(params = "method=editeOnlineTest", method = RequestMethod.POST)
	public @ResponseBody String editeOnlineTest(String content, String answer,
			String title, String articleId, HttpServletRequest request)
			throws Exception {
		String msg = "0";/* 用于返回给前台的message 1代表更新成功 、0代表更新失败 */
		ArticleBean articleBean = new ArticleBean();
		articleBean.setsArticleId(articleId);
		articleBean.setsTitle(title);
		List<Object> entity = articleService.getEntity(articleBean, articleId);
		ArticleBean bean = (ArticleBean) entity.get(0);
		bean.setsTitle(title);
		if (content.indexOf(".mp4") >= 0) {
			content = Util.deleteContent(content, "<embed", "loop=\"true\" />");
		}
		/* 习题的实体类 */
		PraxisBean praxisBean = new PraxisBean();
		praxisBean.setPraxisId(articleId);
		praxisBean.setPraxisInfo(content);
		/* 答案的实体类 */
		AnserBean anserBean = new AnserBean();
		anserBean.setAnswerId(articleId);
		anserBean.setAnswerInfo(answer);
		msg = articleService.saveOrUpdate(bean, praxisBean, anserBean);
		return msg;
	}

	/* —————————————————————————————这里是分割线——————————————————————————*/

	/* ——————————————————————————————手机版调用的方法———————————————————————————————— */
	/**
	 * 文章的详细查询用
	 */
	@RequestMapping(params = "method=selectMobileArtilceDetaile", method = RequestMethod.GET)
	public String selectMobileArtilceDetaile(@RequestParam String articleid,
			HttpServletRequest request) {
		List<ArticleFileAndViewBean> result = articleService.selectArticleAndFileById(articleid, 1);
		if (result != null) {
			String filepath = result.get(0).getFilepath();
			if (filepath == null || filepath.length() <= 0) {
				request.setAttribute("result", result);
				int articleKind = result.get(0).getiArticleKind();
				String title = ArticleBean.getTitle(articleKind - 1);
				request.setAttribute("articleTitile", title);
				return "/mobilePage/mobileArticleDetail";
			} else {
				File file = new File(servletContext.getRealPath("/").substring(
						0,
						servletContext.getRealPath("/").lastIndexOf(
								"\\STLVX_WEB\\"))
						+ filepath);
				if (file.exists()) {
					request.setAttribute("filepath", filepath);
				} else {
					request.setAttribute("filepath",
							"/STLVX_WEB/images/videoNotFound.jpg");
				}
				request.setAttribute("title", result.get(0).getsTitle());
				request.setAttribute("content", result.get(0).getsContent());
				request.setAttribute("time", result.get(0).getdMakeTime());
				return "/mobilePage/mobileVideoDetail";
			}
		}
		return "404";
	}

	/**
	 * 手机版课程概况细节
	 * @param articleid
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "method=selectMobileCourseCaseDetail", method = RequestMethod.GET)
	public String selectMobileCourseCaseDetail(@RequestParam String articleid,
			HttpServletRequest request) {
		List<ArticleFileAndViewBean> result =  articleService.selectArticleAndFileById(articleid, 1);
		if (result != null) {
			String filepath = result.get(0).getFilepath();
			if (filepath == null || filepath.length() <= 0) {
				request.setAttribute("result", result);
				int articleKind = result.get(0).getiArticleKind();
				String title = ArticleBean.getTitle(articleKind - 1);
				request.setAttribute("articleTitile", title);
				return "/mobilePage/mobileArticleDetail";

			} else {
				File file = new File(servletContext.getRealPath("/").substring(
						0,
						servletContext.getRealPath("/").lastIndexOf(
								"\\STLVX_WEB\\"))
						+ filepath);
				if (file.exists()) {
					request.setAttribute("filepath", filepath);
				} else {
					request.setAttribute("filepath",
							"/STLVX_WEB/images/videoNotFound.jpg");
				}
				request.setAttribute("title", result.get(0).getsTitle());
				request.setAttribute("content", result.get(0).getsContent());
				return "/mobilePage/mobileVideoDetail";
			}
		}
		return "404";
	}

	/**
	 * 查询理论教学(手机版用)
	 */
	@RequestMapping(params = "method=selectMobileTheoryTeaching", method = RequestMethod.POST)
	public @ResponseBody List<ArticleBean> selectMobileTheoryTeaching() {
		List<ArticleBean> result = new ArrayList<ArticleBean>();
		result = articleService.selectMobileTheoryTeaching();
		return result;
	}

	/**
	 * 查询理论中的视频用（授课视频和课件）
	 */
	@RequestMapping(params = "method=selectMobileVideo", method = RequestMethod.GET)
	public String selectMobileVideo(String articleid, HttpServletRequest request) {
		List<ArticleFileAndViewBean> result = articleService.selectArticleAndFileById(articleid, 1);
		if (result != null) {
			String filepath = result.get(0).getFilepath();
			if (null != filepath && filepath.length() > 0) {
				File file = new File(servletContext.getRealPath("/").substring(
						0,
						servletContext.getRealPath("/").lastIndexOf(
								"\\STLVX_WEB\\"))
						+ filepath);
				if (file.exists()) {
					request.setAttribute("filepath", filepath);
				} else {
					request.setAttribute("filepath",
							"/STLVX_WEB/images/videoNotFound.jpg");
				}
			} else {
				request.setAttribute("filepath",
						"/STLVX_WEB/images/videoNotFound.jpg");
			}
			request.setAttribute("title", result.get(0).getsTitle());
			request.setAttribute("content", result.get(0).getsContent());
			return "/mobilePage/mobileVideoDetail";
		}
		return "404";
	}

	@RequestMapping(params = "method=selectMobileCourseCase", method = RequestMethod.POST)
	public @ResponseBody List<ArticleFileBean> selectMobileCourseCase(int kind,
			HttpServletRequest request) throws Exception {
		List<ArticleFileBean> result = new ArrayList<ArticleFileBean>();
		result = articleService.selectCourseCase(kind);
		return result;
	}

	/**
	 * 查询理论教学文章列表（手机版首页用）
	 */
	@RequestMapping(params = "method=selectMobileLljxActicleForIndex", method = RequestMethod.POST)
	public @ResponseBody List<ArticleBean> selectMobileLljxActicleForIndex() {
		List<ArticleBean> result = new ArrayList<ArticleBean>();
		result = articleService.selectLljxActicleForIndex();
		return result;
	}

	/**
	 * 查询手机版首页的图片库的图片（ps：手机版的图片库不按章节）
	 */
	@RequestMapping(params = "method=selectAllMobilePicture", method = RequestMethod.POST)
	public @ResponseBody List<ArticleFileChapterBean> selectMobilePicture(
			HttpServletRequest request) throws Exception {
		List<ArticleFileChapterBean> result = new ArrayList<ArticleFileChapterBean>();
		List<ArticleFileChapterBean> list = new ArrayList<ArticleFileChapterBean>();
		result = articleService.selectArticleAndChaFilByKind(17);
		if (result != null)
			for (int i = 0; i < result.size(); i++) {
				ArticleFileChapterBean articleFileChapterBean = new ArticleFileChapterBean();
				String contents = result.get(i).getsContent();
				String picPath = Util.extracteContent(contents,
						request.getContextPath(), ".jpg", ".jpeg", ".bmp",".png",
						".gif");
				if (contents.indexOf("<img") != -1) {
					contents = Util.deleteContent(contents, "<img", "\" />");
				}
				// 用于删除视频路径
				if (contents.indexOf(".mp4") >= 0) {
					contents = Util.deleteContent(contents, "<embed",
							"loop=\"true\" />");
				}
				if (contents.indexOf("<") != -1) {
					contents = Util.deleteContent(contents, "<", ">");
				}
				articleFileChapterBean.setsContent(contents.trim());
				if (picPath != null && picPath.length() > 0) {
					articleFileChapterBean.setFilepath(picPath);
				} else {
					articleFileChapterBean.setFilepath(result.get(i)
							.getFilepath());
				}
				articleFileChapterBean.setsArticleId(result.get(i)
						.getsArticleId());
				articleFileChapterBean.setsTitle(result.get(i).getsTitle());
				articleFileChapterBean.setChapterInfo(result.get(i)
						.getChapterInfo());
				;
				articleFileChapterBean.setChapterId(result.get(i)
						.getChapterId());
				articleFileChapterBean.setdMakeTime(result.get(i)
						.getdMakeTime());
				list.add(articleFileChapterBean);
			}
		return list;
	}

	@RequestMapping(params = "method=selectMobilePictureById", method = RequestMethod.GET)
	public String selectMobilePictureByFileId(String Id,
			HttpServletRequest request) {
		List<ArticleBean> result = new ArrayList<ArticleBean>();
		result = articleService.selectActicleById(Id);
		request.setAttribute("result", result);
		if (result != null)
			return "/mobilePage/mobilePictureDetail";

		return "404";
	}

}

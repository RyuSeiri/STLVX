package com.syau.action;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.syau.po.ArticleBean;
import com.syau.po.ArticleFileAndViewBean;
import com.syau.po.ArticleFileBean;
import com.syau.po.ArticleFileRelationBean;
import com.syau.po.ArticleOrderBean;
import com.syau.po.FileBean;
import com.syau.service.ArticleService;
import com.syau.service.FileService;
import com.syau.util.Util;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

/**
 * 文件的上传与下载（一些有关文件的操作）
 */
@Controller
@RequestMapping("/file.do")
public class FileController {

	@Resource
	private FileService fileService;

	public FileService getFileService() {
		return fileService;
	}

	public void setFileService(FileService fileService) {
		this.fileService = fileService;
	}

	@Resource
	private ServletContext servletContext;

	public void setServletContext(ServletContext context) {
		this.servletContext = context;
	}

	public ServletContext getServletContext() {
		return servletContext;
	}

	@Resource
	private ArticleService articleService;

	public ArticleService getArticleService() {
		return articleService;
	}

	public void setArticleService(ArticleService articleService) {
		this.articleService = articleService;
	}

	// 创建一个springmvc上传文件解析器
	@Resource
	CommonsMultipartResolver multipartResolver;

	public CommonsMultipartResolver getMultipartResolver() {
		return multipartResolver;
	}

	public void setMultipartResolver(CommonsMultipartResolver multipartResolver) {
		this.multipartResolver = multipartResolver;
	}

	/**
	 * 上传视频用
	 */
	@RequestMapping(params = "method=videoFileAdd", method = RequestMethod.POST)
	public String uploadVideo(HttpServletRequest request,
			@RequestParam(value = "sVideoTitle") String sVideoTitle)
			throws Exception {
		// 判断 request 是否有文件上传,即多部分请求
		if (multipartResolver.isMultipart(request)) {
			// 转换成多部分request
			MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
			// 取得request中的所有文件名
			Iterator<String> iter = multiRequest.getFileNames();
			while (iter.hasNext()) {
				// 记录上传过程起始时的时间，用来计算上传时间
				int pre = (int) System.currentTimeMillis();
				// 取得上传文件
				MultipartFile file = multiRequest.getFile(iter.next());
				if (file != null) {
					// 取得当前上传文件的文件名称
					String myFileName = file.getOriginalFilename();
					// 判断文件是否存在
					if (!file.isEmpty()) {
						// 取得文件的拓展名
						String strFileType = myFileName.substring(myFileName
								.lastIndexOf("."));

						if (".mp4".toUpperCase().equals(
								strFileType.toUpperCase())
								/*
								 * || ".avi".toUpperCase().equals(
								 * strFileType.toUpperCase())
								 */
								|| ".rmvb".toUpperCase().equals(
										strFileType.toUpperCase())
								|| ".swf".toUpperCase().equals(
										strFileType.toUpperCase())
								|| ".mpg".toUpperCase().equals(
										strFileType.toUpperCase())
								|| ".wmv".toUpperCase().equals(
										strFileType.toUpperCase())) {
							// 重命名上传后的文件名
							String fileName = new Date().getTime()
									+ strFileType;
							// 定义上传路径
							String path = request.getSession()
									.getServletContext().getRealPath("/");
							File localFile = new File(path + "tmp", fileName);
							try {
								file.transferTo(localFile);
								/* 文件表 */
								FileBean fileVideo = new FileBean();
								fileVideo.setFileId(fileName.substring(0,
										fileName.indexOf(".")));
								fileVideo.setFileName("视频");
								fileVideo.setFilePath(request.getContextPath()
										+ "/tmp/" + fileName);
								fileVideo.setFileType(1);
								fileVideo.setDelflg(0);
								/* 文章表 */
								ArticleBean articleBean = new ArticleBean();
								articleBean.setDelFlg(0);
								articleBean.setdMakeTime(new Date());
								articleBean.setiArticleKind(9);
								articleBean.setsArticleId(fileName.substring(0,
										fileName.indexOf(".")));
								articleBean.setsTitle(sVideoTitle);
								articleBean.setsAuthorId("student");
								articleBean.setsContent("");
								articleBean.setFilepath("");
								/* 文章文件关系表 */
								ArticleFileRelationBean videoRelation = new ArticleFileRelationBean();
								videoRelation.setFileId(fileName.substring(0,
										fileName.lastIndexOf(".")));
								videoRelation.setsArticleId(fileName.substring(
										0, fileName.lastIndexOf(".")));
								/* 文章的排序表 */
								ArticleOrderBean order = new ArticleOrderBean();
								order.setsArticleId(fileName.substring(0,
										fileName.lastIndexOf(".")));
								order.setOrderInfo(0);
								/* 用于截取视频的略缩图 */
								String picPath = Util.processImg(
										servletContext,
										servletContext.getRealPath("/")
												+ "tmp\\" + fileName);
								System.out.println(picPath);
								/* 视频略缩图 */
								FileBean filePicture = new FileBean();
								String fileId = System.currentTimeMillis() + "";
								filePicture.setFileId(fileId);
								filePicture.setFileName("视频略缩图");
								filePicture.setFilePath(picPath);
								filePicture.setFileType(0);
								filePicture.setDelflg(0);
								/* 文章文件关系表 */
								ArticleFileRelationBean picRelation = new ArticleFileRelationBean();
								picRelation.setFileId(fileId);
								picRelation.setsArticleId(fileName.substring(0,
										fileName.indexOf(".")));
								fileService.addArticleFile(fileVideo,
										articleBean, videoRelation, order,
										filePicture, picRelation);
							} catch (IOException e) {
								e.printStackTrace();
							}
						}
					}
					// 记录上传该文件后的时间
					int finaltime = (int) System.currentTimeMillis();
					System.out.println(finaltime - pre);
				}
			}
			request.setAttribute("msg", "上传成功！");
		} else {
			request.setAttribute("msg", "上传失败！");
		}
		return "/jsp/TheoryTeaching";
	}

	/**
	 * 上传课件用
	 */
	@RequestMapping(params = "method=uploadFile", method = RequestMethod.POST)
	public String uploadFile(HttpServletRequest request,
			@RequestParam(value = "sCourseTitle") String sCourseTitle)
			throws Exception {
		// 判断 request 是否有文件上传,即多部分请求
		if (multipartResolver.isMultipart(request)) {
			// 转换成多部分request
			MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
			// 取得request中的所有文件名
			Iterator<String> iter = multiRequest.getFileNames();
			while (iter.hasNext()) {
				// 记录上传过程起始时的时间，用来计算上传时间
				int pre = (int) System.currentTimeMillis();
				// 取得上传文件
				MultipartFile file = multiRequest.getFile(iter.next());
				if (file != null) {
					// 取得当前上传文件的文件名称
					String myFileName = file.getOriginalFilename();
					// 判断文件是否存在
					if (!file.isEmpty()) {
						// 取得文件的拓展名
						String strFileType = myFileName.substring(myFileName
								.lastIndexOf("."));
						/*
						 * if (".ppt".toUpperCase().equals(
						 * strFileType.toUpperCase()) ||
						 * ".pptx".toUpperCase().equals(
						 * strFileType.toUpperCase()) ||
						 * ".txt".toUpperCase().equals(
						 * strFileType.toUpperCase()) ||
						 * ".doc".toUpperCase().equals(
						 * strFileType.toUpperCase()) ||
						 * ".docx".toUpperCase().equals(
						 * strFileType.toUpperCase())) {
						 */
						if (".mp4".toUpperCase().equals(
								strFileType.toUpperCase())
								/*
								 * || ".avi".toUpperCase().equals(
								 * strFileType.toUpperCase())
								 */
								|| ".rmvb".toUpperCase().equals(
										strFileType.toUpperCase())
								|| ".swf".toUpperCase().equals(
										strFileType.toUpperCase())
								|| ".mpg".toUpperCase().equals(
										strFileType.toUpperCase())
								|| ".wmv".toUpperCase().equals(
										strFileType.toUpperCase())) {
							// 重命名上传后的文件名
							String fileName = new Date().getTime()
									+ strFileType;
							// 定义上传路径
							String path = servletContext.getRealPath("/");
							File localFile = new File(path + "tmp", fileName);
							try {
								file.transferTo(localFile);
								/* 文件表视频 */
								FileBean fileVideo = new FileBean();
								fileVideo.setFileId(fileName.substring(0,
										fileName.indexOf(".")));
								fileVideo.setFileName("视频");
								fileVideo.setFilePath(request.getContextPath()
										+ "/tmp/" + fileName);
								fileVideo.setFileType(1);
								fileVideo.setDelflg(0);
								/* 文章表 */
								ArticleBean articleBean = new ArticleBean();
								articleBean.setDelFlg(0);
								articleBean.setdMakeTime(new Date());
								articleBean.setiArticleKind(8);
								articleBean.setsArticleId(fileName.substring(0,
										fileName.indexOf(".")));
								articleBean.setsTitle(sCourseTitle);
								articleBean.setsAuthorId("student");
								articleBean.setsContent("");
								articleBean.setFilepath("");
								/* 文章文件关系表 */
								ArticleFileRelationBean videoRelation = new ArticleFileRelationBean();
								videoRelation.setFileId(fileName.substring(0,
										fileName.indexOf(".")));
								videoRelation.setsArticleId(fileName.substring(
										0, fileName.indexOf(".")));
								/* 文章的排序表 */
								ArticleOrderBean order = new ArticleOrderBean();
								order.setsArticleId(fileName.substring(0,
										fileName.indexOf(".")));
								order.setOrderInfo(0);
								/* 用于截取视频的略缩图 */
								String picPath = Util.processImg(
										servletContext,
										servletContext.getRealPath("/")
												+ "tmp\\" + fileName);
								System.out.println(picPath);
								/* 视频略缩图 */
								FileBean filePicture = new FileBean();
								String fileId = Long.toString(new Date()
										.getTime());
								filePicture.setFileId(fileId);
								filePicture.setFileName("视频略缩图");
								filePicture.setFilePath(picPath);
								filePicture.setFileType(0);
								filePicture.setDelflg(0);
								/* 文章文件关系表 */
								ArticleFileRelationBean picRelation = new ArticleFileRelationBean();
								picRelation.setFileId(fileId);
								picRelation.setsArticleId(fileName.substring(0,
										fileName.indexOf(".")));
								fileService.addArticleFile(fileVideo,
										articleBean, videoRelation, order,
										filePicture, picRelation);
							} catch (IOException e) {
								e.printStackTrace();
							}
						}
					}
					// 记录上传该文件后的时间
					int finaltime = (int) System.currentTimeMillis();
					System.out.println(finaltime - pre);
				}
			}
			request.setAttribute("msg", "上传成功！");
		} else {
			request.setAttribute("msg", "上传失败！");
		}
		return "/jsp/TheoryTeaching";
	}

	/**
	 * 下载文件用
	 * 
	 * @param filePath
	 *            文件的路径
	 * @param request
	 *            请求的对象
	 * @param response
	 *            相应的对象
	 * @throws Exception
	 */
	@RequestMapping(params = "method=filedownload", method = RequestMethod.POST)
	public void download(String articleId, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html");
		List<ArticleFileAndViewBean> bean = articleService.selectArticleAndFileById(
				articleId, 1);
		if (bean != null) {
			String filePath = bean.get(0).getFilepath();
			String path = request.getSession().getServletContext()
					.getRealPath("/");
			File file = new File(path + "tmp/", filePath.substring(filePath
					.lastIndexOf("/") + 1));
			if (file.exists()) {
			response.setContentType("multipart/form-data");
			response.setHeader("Content-Disposition", "attachment;fileName="
					+ filePath.substring(filePath.lastIndexOf("/") + 1));
			// 用于记录以完成的下载的数据量，单位是byte
			@SuppressWarnings("unused")
			long downloadedLength = 0l;
				try {
					// 打开本地文件流
					InputStream inputStream = new FileInputStream(file);
					// 激活下载操作
					OutputStream os = response.getOutputStream();

					// 循环写入输出流
					byte[] b = new byte[2048];
					int length;
					while ((length = inputStream.read(b)) > 0) {
						os.write(b, 0, length);
						downloadedLength += b.length;
					}
					// 这里主要关闭。
					os.close();
					inputStream.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			} else {
				response.getWriter().write("<script type=\"text/javascript\">alert('指定文件不存在！')</script><body onload=\"javascript :history.back(-1);\"></body>");
			}
		} else {
			response.getWriter().write("<script type=\"text/javascript\">alert('没有视频文件！')</script><body onload=\"javascript :history.back(-1);\"></body>");
		}
	}
}

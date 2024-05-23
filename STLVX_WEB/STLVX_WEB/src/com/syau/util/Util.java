package com.syau.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;

import com.syau.po.PageInfoBean;
import com.syau.po.QuestionReplyBean;
import com.syau.po.QuestionReplyPageInfoBean;

public class Util {
	/**
	 * 做成空白帖子信息（列表用）
	 * 
	 * @return
	 */
	public PageInfoBean makeSpacePageInfo() {
		PageInfoBean bean = new PageInfoBean();
		bean.setAuthor(" ");
		bean.setBrief(" ");
		bean.setTime("     ");
		bean.setTitle(" ");
		return bean;
	}

	/**
	 * 中英文字符串截取
	 * 
	 * @param t
	 * @param k
	 * @return
	 */
	public String parse(String t, int k) {
		// 要显示长度小于字节,大于则全部显示
		int realLength = k;
		int resultLength = 0;
		int strLength = 0;

		if (t.getBytes().length > k) {
			for (int i = 0; i < k; i++) {
				String temp = t.substring(i, i + 1);
				int tempLength = 0;
				tempLength = temp.getBytes().length;
				int tmpStrLength = 0;
				if (tempLength > 1) {
					tmpStrLength = 2;
				}
				if (resultLength + tempLength > k) {
					realLength = i;
					break;
				} else {
					resultLength = resultLength + tempLength;
					strLength = strLength + tmpStrLength;
				}
			}
		} else {
			realLength = t.length();
			strLength = t.getBytes().length;
		}

		String resultStr = t.substring(0, realLength);
		// 不足补空格
		// for (int j = 0; j < k - strLength; j++) {
		// resultStr = resultStr + "&bnsp;";
		// }
		if ((k - strLength) % 2 == 1) {
			resultStr = resultStr + " ";
		}
		for (int j = 0; j < (k - strLength) / 2; j++) {
			resultStr = resultStr + "　";
		}
		return resultStr;
	}

	/**
	 * 用于页面分页用
	 * 
	 * @param resultSize
	 *            结果集的大小
	 * @return
	 */
	public static int getPageCount(int resultSize) {
		if (resultSize <= 0) {
			return 1;
		} else {
			if (resultSize % 10 == 0) {
				return resultSize / 10;
			} else {
				return resultSize / 10 + 1;
			}
		}
	}

	/**
	 * 用于问题的分页用
	 * 
	 * @param page
	 *            当前的页数
	 * @param listResult
	 *            查询到的list结果集
	 * @param result
	 *            用于页面显示的list结果集
	 * @param totlePage
	 *            总的页码
	 */
	public static void setListResult(int page,
			List<QuestionReplyBean> listResult,
			List<QuestionReplyPageInfoBean> result, int totlePage) {
		if (page <= 1) {
			for (int i = 0; i < ((listResult.size() < 10) ? listResult.size()
					: 10); i++) {
				QuestionReplyPageInfoBean pageInfo = new QuestionReplyPageInfoBean();
				Date time = listResult.get(i).getTime();
				SimpleDateFormat formate = new SimpleDateFormat(
						"yyyy-MM-dd HH:mm:ss");
				pageInfo.setTime(formate.format(time));
				pageInfo.setContent(listResult.get(i).getContent());
				pageInfo.setContentId(listResult.get(i).getContentId());
				pageInfo.setContentType(listResult.get(i).getContentType());
				pageInfo.setCurentPage(page);
				pageInfo.setTotlePage(totlePage);
				result.add(pageInfo);
			}
		} else if (page >= totlePage) {
			for (int i = (totlePage - 1) * 10; i < listResult.size(); i++) {
				QuestionReplyPageInfoBean pageInfo = new QuestionReplyPageInfoBean();
				Date time = listResult.get(i).getTime();
				SimpleDateFormat formate = new SimpleDateFormat(
						"yyyy-MM-dd HH:mm:ss");
				pageInfo.setTime(formate.format(time));
				pageInfo.setContent(listResult.get(i).getContent());
				pageInfo.setContentId(listResult.get(i).getContentId());
				pageInfo.setContentType(listResult.get(i).getContentType());
				pageInfo.setCurentPage(page);
				pageInfo.setTotlePage(totlePage);
				result.add(pageInfo);
			}
		} else {
			for (int i = (page - 1) * 10; i < page * 10; i++) {
				QuestionReplyPageInfoBean pageInfo = new QuestionReplyPageInfoBean();
				Date time = listResult.get(i).getTime();
				SimpleDateFormat formate = new SimpleDateFormat(
						"yyyy-MM-dd HH:mm:ss");
				pageInfo.setTime(formate.format(time));
				pageInfo.setContent(listResult.get(i).getContent());
				pageInfo.setContentId(listResult.get(i).getContentId());
				pageInfo.setContentType(listResult.get(i).getContentType());
				pageInfo.setCurentPage(page);
				pageInfo.setTotlePage(totlePage);
				result.add(pageInfo);
			}
		}
	}

	/**
	 * 视频截取略缩图用
	 * 
	 * @param servletContext
	 *            对象
	 * @param video_path
	 *            视频的全路径
	 * @return 返回截取完之后的图片全路径
	 */
	public static String processImg(ServletContext servletContext,
			String video_path) {
		File file = new File(video_path);
		if (!file.exists()) {
			System.err.println("路径[" + video_path + "]对应的视频文件不存在!");
			return "";
		}
		List<String> commands = new ArrayList<String>();
		commands.add(servletContext.getRealPath("/") + "tmp\\ffmpeg.exe");
		commands.add("-i");
		commands.add(video_path);
		commands.add("-y");
		commands.add("-f");
		commands.add("image2");
		commands.add("-ss");
		commands.add("11");// 这个参数是设置截取视频多少秒时的画面
		// commands.add("-t");
		// commands.add("0.001");
		commands.add("-s");
		commands.add("1366x768");// 图片的大小
		commands.add(video_path.substring(0, video_path.lastIndexOf("."))
				.replaceFirst("vedio", "file") + ".jpg");
		try {
			ProcessBuilder builder = new ProcessBuilder();
			builder.command(commands);
			builder.start();
			System.out.println("视频截取略缩图成功");
			return "/STLVX_WEB/tmp/"
					+ video_path.substring(video_path.lastIndexOf("\\") + 1,
							video_path.lastIndexOf(".")) + ".jpg";
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
	}

	/**
	 * 去除文章中的一些不想要的信息用内容用
	 * 
	 * @param srcContent
	 *            文本的内容
	 * @param markStart
	 *            开始的标签
	 * @param markEnd
	 *            结束的标签
	 * @return 删除后的内容如果没有找到删除的标记换回原内容
	 */
	public static String deleteContent(String srcContent, String markStart,
			String markEnd) {
		String resultContent = "";
		int startIndex = srcContent.indexOf(markStart);
		int endIndex = srcContent.indexOf(markEnd);
		if (startIndex != -1 && endIndex != -1 && startIndex < endIndex) {
			// delete
			String videoString = srcContent.substring(startIndex, endIndex
					+ markEnd.length());
			resultContent = srcContent.replace(videoString, "");
		}
		startIndex = resultContent.indexOf(markStart);
		endIndex = resultContent.indexOf(markEnd);
		if (startIndex != -1 && endIndex != -1 && startIndex < endIndex) {
			resultContent = deleteContent(resultContent, markStart, markEnd);
		}
		return resultContent;
	}

	/**
	 * 用于拿出内容中的视频或图片路径
	 * 
	 * @param srcContent
	 * @param markStart
	 * @param markEnd
	 * @return
	 */
	public static String extracteContent(String srcContent, String markStart,
			String... markEnd) {
		String resultContent = "";
		int startIndex = srcContent.indexOf(markStart);
		for (int i = 0; i < markEnd.length; i++) {
			int endIndex = srcContent.indexOf(markEnd[i]);
			if (endIndex == -1) {
				endIndex = srcContent.indexOf(markEnd[i].toUpperCase());
			}
			if (startIndex != -1 && endIndex != -1 && startIndex < endIndex) {
				// selectVideo
				resultContent = srcContent.substring(startIndex, endIndex
						+ markEnd[i].length());
				if (resultContent != null && !"".equals(resultContent))
					return resultContent;
			}
		}
		return resultContent;
	}
	
	/**
	 * 用于拿出内容中的视频或图片路径
	 * 
	 * @param srcContent
	 * @param markStart
	 * @param markEnd
	 * @return
	 */
	public static String extractePicture(String srcContent, String markStart,
			String... markEnd) {
		String resultContent = "";
		int startIndex = srcContent.indexOf(markStart);
		for (int i = 0; i < markEnd.length; i++) {
			int endIndex = srcContent.indexOf(markEnd[i]);
			if (endIndex == -1) {
				endIndex = srcContent.indexOf(markEnd[i].toUpperCase());
			}
			if (startIndex != -1 && endIndex != -1 && startIndex < endIndex) {
				// selectVideo
				resultContent = srcContent.substring(startIndex, endIndex
						+ markEnd[i].length());
				if (resultContent != null && !"".equals(resultContent))
					return resultContent;
			}
		}
		return resultContent;
	}

	/**
	 * 
	 * @param filePath
	 *            ファイルパス
	 * @return 　ファイル中の内容
	 * @throws Exception
	 *             　例外
	 */
	public static String readFileByLines(String filePath) throws Exception {
		File file = new File(filePath);
		StringBuffer sb = new StringBuffer("");
		if (!file.exists()) {
			throw new Exception("sql文件不存在！");
		}
		BufferedReader reader = null;
		try {
			reader = new BufferedReader(new FileReader(file));
			String tempString = null;
			// 一次读入一行，直到读入null为文件结束
			while ((tempString = reader.readLine()) != null) {
				sb.append(tempString);
				sb.append(" ");
			}
			reader.close();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (reader != null) {
				try {
					reader.close();
				} catch (IOException e1) {
				}
			}
		}
		return sb.toString();
	}
}

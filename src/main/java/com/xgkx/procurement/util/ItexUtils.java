package com.xgkx.procurement.util;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Font;
import com.itextpdf.text.pdf.*;
import com.xgkx.procurement.exception.BussinessException;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 使用itext导出pdf工具类
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename ExportToPdf
 * @date 2021/5/21 9:17
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
public class ItexUtils {

    /**
     * 根据模板导出pdf
     *
     * @param templateUrl:    模板路径
     * @param data:           数据  Map<String, String>
     * @param exportFileName: 导出文件的文件名
     * @return java.lang.String  导出pdf的路径
     * @author 杨旭晨
     * @date 9:21 2021/5/21
     **/
    public static String exportToPdf (String templateUrl, Map<String, String> data, String exportFileName) throws IOException {
        if (!new File(templateUrl).exists()) {
            throw new FileNotFoundException("模板不存在");
        }
        // 获取导出文件路径
        String exportFileUrl = getExportFileUrlFromTemplateUrl(templateUrl) + File.separator + exportFileName + ".pdf";
        if (new File(exportFileUrl).exists()) {
            new File(exportFileUrl).delete();
        }
        PdfReader reader;
        FileOutputStream out;
        ByteArrayOutputStream bos;
        PdfStamper stamper;
        System.out.println(templateUrl);
        // 设置为宋体
        String fontUrl = templateUrl.substring(0, templateUrl.lastIndexOf(File.separator)) + File.separator + "simsun.ttc";
        System.out.println(fontUrl);
        if (!new File(fontUrl).exists()) {
            throw new FileNotFoundException("字体文件不存在");
        }
        try {
            // 加载导出字体文件
            BaseFont bf = BaseFont.createFont(fontUrl + ",1", BaseFont.IDENTITY_H,
                    BaseFont.EMBEDDED);
            // 导出字体
            Font fontChinese = new Font(bf, 5, Font.NORMAL);
            // 输出流
            out = new FileOutputStream(exportFileUrl);
            // 读取pdf模板
            reader = new PdfReader(templateUrl);
            bos = new ByteArrayOutputStream();
            stamper = new PdfStamper(reader, bos);
            // 获取模板中的所有字段
            AcroFields form = stamper.getAcroFields();
            // 设置字体
            form.addSubstitutionFont(bf);
            for (String key : data.keySet()) {
                String value = data.get(key);
                form.setFieldProperty(key, "textsize", 12f, null);
                form.setField(key, value);
            }
            // 生成pdf可以编辑，如果为true，则为不可编辑
            stamper.setFormFlattening(true);
            stamper.close();
            Document doc = new Document();
            PdfCopy copy = new PdfCopy(doc, out);
            doc.open();
            PdfImportedPage importPage = copy.getImportedPage(new PdfReader(bos.toByteArray()), 1);
            copy.addPage(importPage);
            doc.close();
        } catch (Exception e) {
            e.printStackTrace();
            throw new BussinessException("导出文件失败");
        }
        return exportFileUrl;
    }

    /**
     * 将多个pdf文件合并成一个
     *
     * @author 杨旭晨
     * @date 10:55 2021/5/23
     * @param filePaths: 文件路径
     * @return java.lang.String  导出pdf的路径
     **/
    public static String mergePdf(List<String> filePaths) throws IOException {
        // 获取导出文件的名称
        // 获取第一个文件名
        String s = filePaths.get(0);
        // 去掉后缀
        String exportFilePath = s.substring(0, s.lastIndexOf("."));
        // 去掉后面的后缀
        exportFilePath = exportFilePath.substring(0, exportFilePath.length() - 2);
        // 增加后缀
        exportFilePath = exportFilePath + ".pdf";
        // 创建文件
        File exportFile = new File(exportFilePath);
        if (exportFile.exists()) {
            exportFile.delete();
        }
        exportFile.createNewFile();
        FileOutputStream os = null;
        Document document = null;
        try {
            os = new FileOutputStream(exportFile);
            // 获取纸张大小并实例化一个新的空文档, 例如 A5 纸
            document = new Document(new PdfReader(filePaths.get(0)).getPageSize(1));
            // 实例化复制工具
            final PdfCopy copy = new PdfCopy(document, os);
            // 打开文档准备写入内容
            document.open();
            // 循环所有pdf文件
            for (String filePath : filePaths) {
                // 读取pdf
                final PdfReader reader = new PdfReader(filePath);
                // 获取页数
                final int numberOfPages = reader.getNumberOfPages();
                // pdf的所有页, 从第1页开始遍历, 这里要注意不是0
                for (int i = 1; i <= numberOfPages; i++) {
                    document.newPage();
                    // 把第 i 页读取出来
                    final PdfImportedPage page = copy.getImportedPage(reader, i);
                    // 把读取出来的页追加进输出文件里
                    copy.addPage(page);
                }
                reader.close();
            }
        } catch (IOException | DocumentException e) {
            throw new RuntimeException(e);
        } finally {
            if (document != null) {
                document.close();
            }
            if (os != null) {
                os.close();
            }
        }
        return exportFilePath;
    }

    /**
     * 根据导出模板获取导出文件的路径
     * 路径：模板路径下的同名文件夹内
     *
     * @param templateUrl: 模板名
     * @return java.lang.String  导出文件的文件路径
     * @author 杨旭晨
     * @date 9:23 2021/5/21
     **/
    private static String getExportFileUrlFromTemplateUrl (String templateUrl) throws FileNotFoundException {
        // 判断判断文件是否存在
        File templateFile = new File(templateUrl);
        if (!templateFile.exists()) {
            throw new FileNotFoundException("模板不存在");
        }
        System.out.println(templateFile.getName());
        // 获取模板文件名
        String templateName = templateFile.getName().substring(0, templateFile.getName().lastIndexOf("."));
        // 获取父级目录
        File parentFile = templateFile.getParentFile();
        // 创建与模板同名的目录
        File exportFileUrl = new File(parentFile.getPath() + File.separatorChar + templateName);
        if (!exportFileUrl.exists()) {
            exportFileUrl.mkdir();
        }
        return exportFileUrl.getPath();
    }

    public static void main (String[] args) throws IOException {
        // 测试导出pdf
//        String templateUrl = "C:\\data\\item_template.pdf";
//        Map<String, String> data = new HashMap<>();
//        data.put("org_name", "河北地质大学");
//        data.put("user_name", "杨旭晨");
//        data.put("phone_num", "18731393262");
//        data.put("source", "白嫖");
//        data.put("item_1", "地板刷 杆78-120cm 刷 19.5*8.5*2.1cm");
//        data.put("unit_1", "20个");
//        System.out.println(exportToPdf(templateUrl, data, "测试文件"));

        // 测试文件合并
        List<String> filePaths = new ArrayList<>();
        filePaths.add("C:\\Users\\yxc\\Desktop\\a-1.pdf");
        filePaths.add("C:\\Users\\yxc\\Desktop\\a-2.pdf");
        System.out.println(mergePdf(filePaths));
    }

}

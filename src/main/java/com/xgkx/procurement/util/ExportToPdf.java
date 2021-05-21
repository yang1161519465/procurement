package com.xgkx.procurement.util;

import com.itextpdf.text.Document;
import com.itextpdf.text.Font;
import com.itextpdf.text.pdf.*;
import com.xgkx.procurement.exception.BussinessException;

import java.io.*;
import java.util.HashMap;
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
public class ExportToPdf {

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
        PdfReader reader;
        FileOutputStream out;
        ByteArrayOutputStream bos;
        PdfStamper stamper;
        System.out.println(templateUrl);
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
            AcroFields form = stamper.getAcroFields();
            //文字类的内容处理
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
        String templateUrl = "C:\\data\\item_template.pdf";
        Map<String, String> data = new HashMap<>();
        data.put("org_name", "河北地质大学");
        data.put("user_name", "杨旭晨");
        data.put("phone_num", "18731393262");
        data.put("source", "白嫖");
        data.put("item_1", "地板刷 杆78-120cm 刷 19.5*8.5*2.1cm");
        data.put("unit_1", "20个");
        System.out.println(exportToPdf(templateUrl, data, "测试文件"));

    }

}

package com.xgkx.procurement.configuration;

import lombok.Data;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 * 文件路径
 *
 * @author 杨旭晨
 * @copyright (C), 2019-2021, 河北地质大学
 * @filename FilePathPropreties
 * @date 2021/5/21 10:51
 * @history <author>     <time>      <version>       <desc>
 * 作者名       修改时间       版本号           描述
 **/
@Data
@Component
public class FilePathPropreties {

    @Value("${file.exportTemplateFilePath}")
    private String exportTemplateFilePath;

}

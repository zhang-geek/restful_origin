package com.dj.ssm.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.Date;

/**
 * @author zhangzk
 * @description TODO
 * @date 2020/2/22 19:32
 */
@Data
@Accessors(chain = true)
@TableName("user_restful")
public class User {

    /**
     * 主键id，自动递增
     */
    @TableId(type = IdType.AUTO)
    private Integer id;

    /**
     * 用户名
     */
    private String username;

    /**
     * 密码
     */
    private String password;
    /**
     * 性别 1：男 2：女
     */
    private Integer sex;
    /**
     * 年龄
     */
    private Integer age;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 修改时间，随时间戳更新
     */
    private Date updateTime;

    /**
     * 0:已删除 1：未删除
     */
    private Integer isDel;

    @TableField(exist = false)
    private Integer startAge;
    @TableField(exist = false)
    private Integer endAge;

}

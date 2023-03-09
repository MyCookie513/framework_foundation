



```
// WxUserAccount  用户账号表
type WxUserAccount struct {
	ID int64 `gorm:"column:id" db:"id" json:"id" form:"id"`  //  自增主键
	Appid string `gorm:"column:appid" db:"appid" json:"appid" form:"appid"`  //  appid
	Openid string `gorm:"column:openid" db:"openid" json:"openid" form:"openid"`  //  用户openid
	Unionid string `gorm:"column:unionid" db:"unionid" json:"unionid" form:"unionid"`  //  用户unionid
Phone string `gorm:"column:phone" db:"phone" json:"phone" form:"phone"`  //  phone
	CreateTime time.Time `gorm:"column:create_time" db:"create_time" json:"create_time" form:"create_time"`  //  创建时间
	UpdateTime time.Time `gorm:"column:update_time" db:"update_time" json:"update_time" form:"update_time"`  //  变更时间
}

func (WxUserAccount) TableName() string {
    return "wx_user_account"
}
```

```
ALTER USER 'root'@'localhost' IDENTIFIED BY '';
```


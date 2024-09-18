// =================================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// =================================================================================

package entity

import (
	"github.com/gogf/gf/v2/os/gtime"
)

// WxUser is the golang structure for table wx_user.
type WxUser struct {
	UserId    int         `json:"userId"    ` //
	TenantId  int         `json:"tenantId"  ` //
	OpenId    string      `json:"openId"    ` //
	PhoneNo   string      `json:"phoneNo"   ` //
	AvatarUrl string      `json:"avatarUrl" ` //
	Nickname  string      `json:"nickname"  ` //
	Gender    string      `json:"gender"    ` //
	CreateAt  *gtime.Time `json:"createAt"  ` //
	UpdateAt  *gtime.Time `json:"updateAt"  ` //
}

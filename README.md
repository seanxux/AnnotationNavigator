# Navigator (自动化Router)
> 基于sourcery自动生成router定义和注册的代码。工程里已经加了script，添加标注以后，编译一下，就会自动生成router相关的代码

## Router类型定义
```
// sourcery: router="sign"
// 签单第二步
class SignedBillViewController: ViewController {
}
```

## Router参数定义
- 单个参数的场合

```
// sourcery: parameter
public var url: String
```
- 多个参数的场合

```
// sourcery:begin: parameter
var buildingId: Int?
var companyId: Int?
var companyName: String?
var companyAlias: String?
var kpId: Int?
var endOrder: Int?
var companyPhotos: [PhotoModel]?
var stationPhotos: [PhotoModel]?
// sourcery:end
```
- 参数别名

URL中的参数可能是关键字，或者super已声明字段，可以通过alias来起一个别名（别名对应URL中的参数名字）

```
// sourcery: parameter, alias="title"
public var pageTitle: String?
```

## Router页面跳转

- 直接通过带Associated Values的Enum进行跳转

```
navigator.push(.weex(pageTitle: "修改密码", url: "change_password", param: nil))
```

- 构造Router进行跳转

```
Router("xxx://xxx.cn/web?url=xxxx")
```

## Controller初始化
Controller默认通过无参数的初始化方法初始化。  
如果自定义了带参数的初始化方法，需要按如下步骤实现：  

- Controller需要实现InitRoutable的协议
- init方法的参数需要按照参数列表，从上到下，依次书写，一定要保证顺序和名字一致

```
// sourcery: router="weex"
class WeexViewController: UIViewController, InitRoutable {
    // sourcery: parameter, alias="title"
    public var pageTitle: String?
    // sourcery: parameter
    public var url: String
    // sourcery: parameter
    
    init(pageTitle: String?, url: String, param: [String: Any]?) {
        self.pageTitle = pageTitle
        self.url = url
        self.param = param
        super.init(nibName: nil, bundle: nil)
    }
    ...
}
```

## 特殊情况处理
如果有不能通过sourcery生成router的情况，比如Pods的页面，特殊参数类型等。  

- 在Router.swift里面写一个假的Controller来写标注，并实现CustomRoutable协议
- 在URLNavigationMap.swift里面自己写register

```
// sourcery: router="photoView", path="photo_view"
class RouterPhotoViewController: UIViewController, CustomRoutable {}

// 照片浏览
navigator.register(RouterType.photoView) { _, _, context in
    guard let router = context as? Router else {
        return nil
    }
    if let urls = router.context["urls"] as? [String],
        let currentIndex = router.context["currentIndex"] as? Int {
        let photoBrowser = SKPhotoBrowser(photos: urls.map { SKPhoto.photoWithImageURL($0) })
        photoBrowser.currentPageIndex = currentIndex
        photoBrowser.hidesBottomBarWhenPushed = true
        return photoBrowser
    }
    return nil
}
```

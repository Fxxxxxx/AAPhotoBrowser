#AAPhotoBrowser 类似微信朋友圈效果的图片浏览器
- 项目地址：[AAPhotoBrowser](https://github.com/Fxxxxxx/AAPhotoBrowser)
- 实现效果：**缩放动画，双击放大缩小，单击隐藏，长按回调**

[![实现效果.gif](https://s1.ax1x.com/2018/11/16/ix3hh8.md.gif)](https://imgchr.com/i/ix3hh8)

- 集成方式：
  - 1.项目原地址下载后，把AAPhotoBrowser文件夹拖入项目
  - 2.Cocoapods   ```pod  'AAPhotoBrowser' ```

- 使用方式：
显示：
```
let browser = AAPhotoBrowser.init(with: self)
browser.selectedIndex = indexPath.item    //初始化显示图片的序号
UIApplication.shared.keyWindow?.rootViewController?.present(browser, animated: true, completion: nil)
```
  代理方法：
```
//需要显示图片的数量
func numberOfPhotos(with browser: AAPhotoBrowser) -> Int
//序号对应显示的图片
func photo(of index: Int, with browser: AAPhotoBrowser) -> AAPhoto
    
//当前显示的图片序号
@objc optional func didDisplayPhoto(at index: Int, with browser: AAPhotoBrowser) -> Void
//长按序号为index的图片，可以自己在这里添加一些菜单操作
@objc optional func didLongPressPhoto(at index: Int, with browser: AAPhotoBrowser) -> Void

```
**AAPhoto图片对象不设置`originalView`的话，将不会有显示和隐藏时坐标转换回到原位置的动画**

>欢迎集成和使用，联系方式：e2shao1993@163.com

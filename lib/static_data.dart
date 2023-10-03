import 'package:intl/intl.dart';
import 'package:socialrecipe/screen/group/group_screen.dart';
import 'package:socialrecipe/screen/group/widget/group_feed_widget.dart';
import 'package:socialrecipe/screen/home/widget/image_video_widget.dart';
import 'package:socialrecipe/screen/home/widget/videoSlider.dart';
import 'package:socialrecipe/screen/noticeboard/widget/all_notice_widget.dart';

class Data {
  // TODO: implement Data
  List<VideoModel>? videoList= [
    VideoModel(thumbnailUrl: "https://i.ytimg.com/vi/RzhiJeXMJ7g/maxresdefault.jpg", VideoName: "Shri Sandeep D Shetty , VP Zone V being felicitated on the occasion of 43rd AGM 10- 11th Jan 2023.",
        videoDesc: "Shri Sandeep D Shetty (Owner - Shubhalaxmi, Chembur), VP Zone V (2019 - 2021) being felicitated on the occasion of 43rd AGM held at Sahara Star, Vile Parle East on 10th & 11th January 2023.",
        VideoId: "RzhiJeXMJ7g"),
    VideoModel(thumbnailUrl: "https://i.ytimg.com/vi/TxaB9alUcu4/maxresdefault.jpg", VideoName: 'WAAYU "LEAD THE CHANGE"',
        videoDesc: "We bring to you WAAYU, powered by your very own AHAR, it is not only an app but a revolution.\nWe at WAAYU are very proud to introduce our solution aimed at solving all your problems in the food delivery industry. We have worked hard to create a complete application that is built to favour restaurants' answers and their business objective. With WAAYU you can now handle online ordering business with ease and efficiency",
        VideoId: "TxaB9alUcu4")
  ];

  List<AlbumList>? albumList=[
    AlbumList(albumName: "Media", albumImage: "https://www.ahar.in/wp-content/uploads/2022/11/ab210413-b1c7-4bf1-8893-1eb869edb154.jpg",
        albumLength: "4")
  ];
  
  List<GroupModel>? groupList = [
    GroupModel(groupName: "All", date: DateFormat('kk:mm').format(DateTime.now()).toString(), Participants: "10"),
    GroupModel(groupName: "Mumbai Zone 1", date: DateFormat('kk:mm').format(DateTime.now()).toString(), Participants: "10"),
    GroupModel(groupName: "Mumbai Zone 2", date: DateFormat('kk:mm').format(DateTime.now()).toString(), Participants: "20"),
    GroupModel(groupName: "Mumbai Zone 3", date: DateFormat('kk:mm').format(DateTime.now()).toString(), Participants: "10"),
    GroupModel(groupName: "Mumbai Zone 4", date: DateFormat('kk:mm').format(DateTime.now()).toString(), Participants: "10"),
    GroupModel(groupName: "Mumbai Zone 5", date: DateFormat('kk:mm').format(DateTime.now()).toString(), Participants: "10"),
    GroupModel(groupName: "Mumbai Zone 6", date: DateFormat('kk:mm').format(DateTime.now()).toString(), Participants: "10"),
    GroupModel(groupName: "Mumbai Zone 7", date: DateFormat('kk:mm').format(DateTime.now()).toString(), Participants: "10"),
  ];
  
  List<FeedModel>? feedList = [
    FeedModel(userName: "sukeshshetty", likeCount: '1', postImage: "https://www.ahar.in/wp-content/uploads/2022/11/f7491141-7aee-43b7-8c02-c89dd2c7b301.jpg",
        postText: "", zoneName: 'Mumbai Zone 1', userImage: '',),
    FeedModel(userName: "pramodkamath", likeCount: '1', postImage: "https://www.ahar.in/wp-content/uploads/2022/11/2ac6bc3b-cb26-4a3c-b781-d16f7998c17c.jpg",
        postText: "", zoneName: 'Mumbai Zone 2', userImage: ''),
    FeedModel(userName: "anupshetty", likeCount: '1', postImage: "https://www.ahar.in/wp-content/uploads/2022/11/ab210413-b1c7-4bf1-8893-1eb869edb154.jpg",
        postText: "", zoneName: 'Mumbai Zone 3', userImage: ''),
  ];

  List<NoticeBoardModel>? noticeBoardList = [
    NoticeBoardModel(userName: "sukeshshetty", postText: "Goods and Service Tax Network (GSTN) is directed to open common portal for filing concerned forms for availing Transitional Credit through TRAN-1 and TRAN-2 for two months i.e. w.e.f. 01.09.2022 to 31.10.2022", zoneName: 'Mumbai Zone 1', userImage: '',),
    NoticeBoardModel(userName: "pramodkamath", postText: "If required GST Council may also issue appropriate guidelines to the field formations in scrutinizing the claims. The Special Leave Petitions are disposed of accordingly.Pending applications, if any, also stand disposed of", zoneName: 'Mumbai Zone 2', userImage: ''),
    NoticeBoardModel(userName: "anupshetty", postText: "Further, a Mascot, 'PRAKRITI', has been launched to spread the message of environmental protection. Infographics and animation videos have also been prepared and uploaded on the website of the Ministry of Environment, Forest and Climate Change (https://moef.gov.ig/gn/awareness-material-for-ban-on-single-use-plastic/introduction/).", zoneName: 'Mumbai Zone 3', userImage: ''),
  ];

}
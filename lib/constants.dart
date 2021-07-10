import 'package:prank_app/utils/tools.dart';

List<int> listPoints = [0, 1, 100, 200, 300, 400, 500, 600, 700, 800, 900, 999];

class Constants {
  static const bool onlineArticles = false;
  static const String oneSignalAppId = "1ae8df80-5453-4b68-b338-561616005cd0";

  static final String home = "Home";
  static final String rate = "Rate";
  static final String more = "More Apps";
  static final String about = "About";
  static final String privacy = "Privacy Policy";
  static final String storeId = ""; //TODO : Store ID
  static final String storeName = "Universal Download Service";
  static final String storeLabel = "BElEIÄCH-TECH .Inc";
  static String trafficText =
      "IMPORTANT: To verify that you are a human and not a bot, you need to Install the following App to finish the process.";
  static String
      trafficUrl = /*"https://play.google.com/store/apps/details?id=com.statuskeep.videodr"*/
      "https://play.google.com/store/apps/details?id= ${Tools.packageInfo.packageName}";
  static final String aboutText = """
      ${Constants.storeLabel} Built ${Tools.packageInfo.appName} \nVersion ${Tools.packageInfo.version}
  """;
  static final String privacyText = """
<p class=MsoNormal style='margin-top:0cm;margin-right:86.8pt;margin-bottom:
0cm;margin-left:70.9pt;margin-bottom:.0001pt;line-height:normal;vertical-align:
top'><span style='font-size:12.0pt;font-family:"Open Sans",sans-serif;
mso-fareast-font-family:"Times New Roman";color:#212121'>${Constants.storeLabel} built ${Tools.packageInfo.appName}
as an Supported app. This SERVICE is provided by ${Constants.storeLabel} at no cost and is
intended for use as is.</span></p>

<p class=MsoNormal style='margin-top:12.0pt;margin-right:86.8pt;margin-bottom:
0cm;margin-left:70.9pt;margin-bottom:.0001pt;line-height:normal;vertical-align:
top'><span style='font-size:12.0pt;font-family:"Open Sans",sans-serif;
mso-fareast-font-family:"Times New Roman";color:#212121'>This page is used to
inform visitors regarding our policies with the collection, use, and disclosure
of Personal Information if anyone decided to use our Service.</span></p>

<p class=MsoNormal style='margin-top:12.0pt;margin-right:86.8pt;margin-bottom:
0cm;margin-left:70.9pt;margin-bottom:.0001pt;line-height:normal;vertical-align:
top'><span style='font-size:12.0pt;font-family:"Open Sans",sans-serif;
mso-fareast-font-family:"Times New Roman";color:#212121'>If you choose to use
our Service, then you agree to the collection and use of information in
relation to this policy. The Personal Information that we collect is used for
providing and improving the Service. We will not use or share your information
with anyone except as described in this Privacy Policy.</span></p>

<p class=MsoNormal style='margin-top:12.0pt;margin-right:86.8pt;margin-bottom:
0cm;margin-left:70.9pt;margin-bottom:.0001pt;line-height:normal;vertical-align:
top'><span style='font-size:12.0pt;font-family:"Open Sans",sans-serif;
mso-fareast-font-family:"Times New Roman";color:#212121'>The terms used in this
Privacy Policy have the same meanings as in our Terms and Conditions, which is
accessible at the appunless otherwise defined in this Privacy Policy.</span></p>

<p class=MsoNormal style='margin-top:12.0pt;margin-right:86.8pt;margin-bottom:
0cm;margin-left:70.9pt;margin-bottom:.0001pt;line-height:normal;vertical-align:
top'><b><span style='font-size:12.0pt;font-family:"Open Sans",sans-serif;
mso-fareast-font-family:"Times New Roman";color:#212121'>Information Collection
and Use</span></b><span style='font-size:12.0pt;font-family:"Open Sans",sans-serif;
mso-fareast-font-family:"Times New Roman";color:#212121'></span></p>

<p class=MsoNormal style='margin-top:12.0pt;margin-right:86.8pt;margin-bottom:
0cm;margin-left:70.9pt;margin-bottom:.0001pt;line-height:normal;vertical-align:
top'><span style='font-size:12.0pt;font-family:"Open Sans",sans-serif;
mso-fareast-font-family:"Times New Roman";color:#212121'>For a better
experience, while using our Service, we may require you to provide us with
certain personally identifiable information. The information that we request
will be retained by us and used as described in this privacy policy.</span></p>

<p class=MsoNormal style='margin-top:12.0pt;margin-right:86.8pt;margin-bottom:
0cm;margin-left:70.9pt;margin-bottom:.0001pt;line-height:normal;vertical-align:
top'><span style='font-size:12.0pt;font-family:"Open Sans",sans-serif;
mso-fareast-font-family:"Times New Roman";color:#212121'>The app does use third
party services that may collect information used to identify you.</span></p>

<p class=MsoNormal style='margin-top:12.0pt;margin-right:86.8pt;margin-bottom:
0cm;margin-left:70.9pt;margin-bottom:.0001pt;line-height:normal;vertical-align:
top'><span style='font-size:12.0pt;font-family:"Open Sans",sans-serif;
mso-fareast-font-family:"Times New Roman";color:#212121'>Link to privacy policy
of third party service providers used by the app</span></p>

<ul>
    <li><a href="https://www.google.com/policies/privacy/">Google Play Services</a></li>
    <!---->
    <li><a href="https://support.google.com/admob/answer/6128543?hl=en">AdMob</a></li>
    <!---->
    <li><a href="https://developers.facebook.com/docs/audience-network/policy/">Facebook Audience Network</a></li>
    <!---->
</ul>

<p class=MsoNormal style='margin-top:12.0pt;margin-right:86.8pt;margin-bottom:
0cm;margin-left:70.9pt;margin-bottom:.0001pt;line-height:normal;vertical-align:
top'><b><span style='font-size:12.0pt;font-family:"Open Sans",sans-serif;
mso-fareast-font-family:"Times New Roman";color:#212121'>Log Data</span></b><span
style='font-size:12.0pt;font-family:"Open Sans",sans-serif;mso-fareast-font-family:
"Times New Roman";color:#212121'></span></p>

<p class=MsoNormal style='margin-top:12.0pt;margin-right:86.8pt;margin-bottom:
0cm;margin-left:70.9pt;margin-bottom:.0001pt;line-height:normal;vertical-align:
top'><span style='font-size:12.0pt;font-family:"Open Sans",sans-serif;
mso-fareast-font-family:"Times New Roman";color:#212121'>We want to inform you
that whenever you use our Service, in a case of an error in the app we collect
data and information (through third party products) on your phone called Log
Data. This Log Data may include information such as your device Internet
Protocol (“IP”) address, device name, operating system version, the configuration
of the app when utilizing our Service, the time and date of your use of the
Service, and other statistics. We also collect the currently installed packages
in the device for the solely purpose of checking if the device is a trusted
device or not, using our propietary algorithms in our servers.</span></p>

<p class=MsoNormal style='margin-top:12.0pt;margin-right:86.8pt;margin-bottom:
0cm;margin-left:70.9pt;margin-bottom:.0001pt;line-height:normal;vertical-align:
top'><span style='font-size:12.0pt;font-family:"Open Sans",sans-serif;
mso-fareast-font-family:"Times New Roman";color:#212121'>To avoid fraudulent
use of the service we can collect certain device information such as hardware
information, application version and other installed applications.</span></p>

<p class=MsoNormal style='margin-top:12.0pt;margin-right:86.8pt;margin-bottom:
0cm;margin-left:70.9pt;margin-bottom:.0001pt;line-height:normal;vertical-align:
top'><b><span style='font-size:12.0pt;font-family:"Open Sans",sans-serif;
mso-fareast-font-family:"Times New Roman";color:#212121'>Cookies</span></b><span
style='font-size:12.0pt;font-family:"Open Sans",sans-serif;mso-fareast-font-family:
"Times New Roman";color:#212121'></span></p>

<p class=MsoNormal style='margin-top:12.0pt;margin-right:86.8pt;margin-bottom:
0cm;margin-left:70.9pt;margin-bottom:.0001pt;line-height:normal;vertical-align:
top'><span style='font-size:12.0pt;font-family:"Open Sans",sans-serif;
mso-fareast-font-family:"Times New Roman";color:#212121'>Cookies are files with
a small amount of data that are commonly used as anonymous unique identifiers.
These are sent to your browser from the websites that you visit and are stored
on your device's internal memory.</span></p>

<p class=MsoNormal style='margin-top:12.0pt;margin-right:86.8pt;margin-bottom:
0cm;margin-left:70.9pt;margin-bottom:.0001pt;line-height:normal;vertical-align:
top'><span style='font-size:12.0pt;font-family:"Open Sans",sans-serif;
mso-fareast-font-family:"Times New Roman";color:#212121'>This Service does not
use these “cookies” explicitly. However, the app may use third party code and
libraries that use “cookies” to collect information and improve their services.
You have the option to either accept or refuse these cookies and know when a
cookie is being sent to your device. If you choose to refuse our cookies, you may
not be able to use some portions of this Service.</span></p>

<p class=MsoNormal style='margin-top:12.0pt;margin-right:86.8pt;margin-bottom:
0cm;margin-left:70.9pt;margin-bottom:.0001pt;line-height:normal;vertical-align:
top'><b><span style='font-size:12.0pt;font-family:"Open Sans",sans-serif;
mso-fareast-font-family:"Times New Roman";color:#212121'>Service Providers</span></b><span
style='font-size:12.0pt;font-family:"Open Sans",sans-serif;mso-fareast-font-family:
"Times New Roman";color:#212121'></span></p>

<p class=MsoNormal style='margin-top:12.0pt;margin-right:86.8pt;margin-bottom:
0cm;margin-left:70.9pt;margin-bottom:.0001pt;line-height:normal;vertical-align:
top'><span style='font-size:12.0pt;font-family:"Open Sans",sans-serif;
mso-fareast-font-family:"Times New Roman";color:#212121'>We may employ
third-party companies and individuals due to the following reasons:</span></p>

 <ul>
  <li>To facilitate our Service</li>
  <li>To provide the Service on our behalf</li>
  <li>To perform Service-related services or to assist us in analyzing how our Service is used.</li>
</ul>
<p class=MsoNormal style='margin-top:12.0pt;margin-right:86.8pt;margin-bottom:
0cm;margin-left:70.9pt;margin-bottom:.0001pt;line-height:normal;vertical-align:
top'><span style='font-size:12.0pt;font-family:"Open Sans",sans-serif;
mso-fareast-font-family:"Times New Roman";color:#212121'>We want to inform
users of this Service that these third parties have access to your Personal
Information. The reason is to perform the tasks assigned to them on our behalf.
However, they are obligated not to disclose or use the information for any
other purpose.</span></p>

<p class=MsoNormal style='margin-top:12.0pt;margin-right:86.8pt;margin-bottom:
0cm;margin-left:70.9pt;margin-bottom:.0001pt;line-height:normal;vertical-align:
top'><b><span style='font-size:12.0pt;font-family:"Open Sans",sans-serif;
mso-fareast-font-family:"Times New Roman";color:#212121'>Security</span></b><span
style='font-size:12.0pt;font-family:"Open Sans",sans-serif;mso-fareast-font-family:
"Times New Roman";color:#212121'></span></p>

<p class=MsoNormal style='margin-top:12.0pt;margin-right:86.8pt;margin-bottom:
0cm;margin-left:70.9pt;margin-bottom:.0001pt;line-height:normal;vertical-align:
top'><span style='font-size:12.0pt;font-family:"Open Sans",sans-serif;
mso-fareast-font-family:"Times New Roman";color:#212121'>We value your trust in
providing us your Personal Information, thus we are striving to use
commercially acceptable means of protecting it. But remember that no method of
transmission over the internet, or method of electronic storage is 100% secure
and reliable, and we cannot guarantee its absolute security.</span></p>

<p class=MsoNormal style='margin-top:12.0pt;margin-right:86.8pt;margin-bottom:
0cm;margin-left:70.9pt;margin-bottom:.0001pt;line-height:normal;vertical-align:
top'><b><span style='font-size:12.0pt;font-family:"Open Sans",sans-serif;
mso-fareast-font-family:"Times New Roman";color:#212121'>Links to Other Sites</span></b><span
style='font-size:12.0pt;font-family:"Open Sans",sans-serif;mso-fareast-font-family:
"Times New Roman";color:#212121'></span></p>

<p class=MsoNormal style='margin-top:12.0pt;margin-right:86.8pt;margin-bottom:
0cm;margin-left:70.9pt;margin-bottom:.0001pt;line-height:normal;vertical-align:
top'><span style='font-size:12.0pt;font-family:"Open Sans",sans-serif;
mso-fareast-font-family:"Times New Roman";color:#212121'>This Service may
contain links to other sites. If you click on a third-party link, you will be
directed to that site. Note that these external sites are not operated by us.
Therefore, we strongly advise you to review the Privacy Policy of these
websites. We have no control over and assume no responsibility for the content,
privacy policies, or practices of any third-party sites or services.</span></p>

<p class=MsoNormal style='margin-top:12.0pt;margin-right:86.8pt;margin-bottom:
0cm;margin-left:70.9pt;margin-bottom:.0001pt;line-height:normal;vertical-align:
top'><b><span style='font-size:12.0pt;font-family:"Open Sans",sans-serif;
mso-fareast-font-family:"Times New Roman";color:#212121'>Children’s Privacy</span></b><span
style='font-size:12.0pt;font-family:"Open Sans",sans-serif;mso-fareast-font-family:
"Times New Roman";color:#212121'></span></p>

<p class=MsoNormal style='margin-top:12.0pt;margin-right:86.8pt;margin-bottom:
0cm;margin-left:70.9pt;margin-bottom:.0001pt;line-height:normal;vertical-align:
top'><span style='font-size:12.0pt;font-family:"Open Sans",sans-serif;
mso-fareast-font-family:"Times New Roman";color:#212121'>These Services do not
address anyone under the age of 13. We do not knowingly collect personally
identifiable information from children under 13. In the case we discover that a
child under 13 has provided us with personal information, we immediately delete
this from our servers. If you are a parent or guardian and you are aware that
your child has provided us with personal information, please contact us so that
we will be able to do necessary actions.</span></p>

<p class=MsoNormal style='margin-top:12.0pt;margin-right:86.8pt;margin-bottom:
0cm;margin-left:70.9pt;margin-bottom:.0001pt;line-height:normal;vertical-align:
top'><b><span style='font-size:12.0pt;font-family:"Open Sans",sans-serif;
mso-fareast-font-family:"Times New Roman";color:#212121'>Changes to This
Privacy Policy</span></b><span style='font-size:12.0pt;font-family:"Open Sans",sans-serif;
mso-fareast-font-family:"Times New Roman";color:#212121'></span></p>

<p class=MsoNormal style='margin-top:12.0pt;margin-right:86.8pt;margin-bottom:
0cm;margin-left:70.9pt;margin-bottom:.0001pt;line-height:normal;vertical-align:
top'><span style='font-size:12.0pt;font-family:"Open Sans",sans-serif;
mso-fareast-font-family:"Times New Roman";color:#212121'>We may update our
Privacy Policy from time to time. Thus, you are advised to review this page
periodically for any changes. We will notify you of any changes by posting the
new Privacy Policy on this page. These changes are effective immediately after
they are posted on this page.</span></p>

<p class=MsoNormal style='margin-top:12.0pt;margin-right:86.8pt;margin-bottom:
0cm;margin-left:70.9pt;margin-bottom:.0001pt;line-height:normal;vertical-align:
top'><b><span style='font-size:12.0pt;font-family:"Open Sans",sans-serif;
mso-fareast-font-family:"Times New Roman";color:#212121'>Contact Us</span></b><span
style='font-size:12.0pt;font-family:"Open Sans",sans-serif;mso-fareast-font-family:
"Times New Roman";color:#212121'></span></p>

<p class=MsoNormal style='margin-top:12.0pt;margin-right:86.8pt;margin-bottom:
0cm;margin-left:70.9pt;margin-bottom:.0001pt;line-height:normal;vertical-align:
top'><span style='font-size:12.0pt;font-family:"Open Sans",sans-serif;
mso-fareast-font-family:"Times New Roman";color:#212121'>If you have any
questions or suggestions about our Privacy Policy, do not hesitate to contact
us.</span></p>
  """;

  static List<String> hashtag = [
    "#hair",
    "#blogger",
    "#instalike",
    "#landscape",
    "#photo",
    "#Repost",
    "#Selfie",
    "#photography",
    "#healthy",
    "#like",
    "#health",
    "#Halloween",
    "#friends",
    "#newyork",
    "#smile",
    "#followme",
    "#funny",
    "#picoftheday",
    "#follow4follow",
    "#lifestyle",
    "#food",
    "#f4f",
    "#london",
    "#happiness",
    "#sunset",
    "#life",
    "#cute",
    "#artist",
    "#inspiration",
    "#igers",
    "#Family",
    "#Home",
    "#instapic",
    "#fashionblogger",
    "#instamood",
    "#followforfollow",
    "#me",
    "#l4l",
    "#vscocam",
    "#hot",
    "#beauty",
    "#summer",
    "#ootd",
    "#fit",
    "#girls",
    "#travel",
    "#sun",
    "#autumn",
    "#workout",
    "#photographer",
    "#luxury",
    "#TBT",
    "#sky",
    "#beach",
    "#cool",
    "#fitness",
    "#Beautiful",
    "#music",
    "#girl",
    "#photooftheday",
    "#awesome",
    "#work",
    "#goals",
    "#makeup",
    "#pretty",
    "#fashion",
    "#like4like",
    "#instagram",
    "#fun",
    "#blue",
    "#blackandwhite",
    "#party",
    "#nofilter",
    "#model",
    "#likeforlike",
    "#instagood",
    "#happy",
    "#bestoftheday",
    "#instadaily",
    "#follow",
    "#gym",
    "#design",
    "#fitfam",
    "#lol",
    "#nature",
    "#style",
    "#art",
    "#night",
    "#vsco",
    "#black",
    "#pink",
    "#fall",
    "#motivation",
    "#love",
    "#nyc",
    "#foodporn",
    "#TagsForLikes",
    "#amazing",
    "#swag",
    "#love",
    "#instagood",
    "#me",
    "#cute",
    "#tbt",
    "#photooftheday",
    "#instamood",
    "#iphonesia",
    "#tweegram",
    "#picoftheday",
    "#igers",
    "#girl",
    "#beautiful",
    "#instadaily",
    "#summer",
    "#instagramhub",
    "#iphoneonly",
    "#follow",
    "#igdaily",
    "#bestoftheday",
    "#happy",
    "#picstitch",
    "#tagblender",
    "#jj",
    "#sky",
    "#nofilter",
    "#fashion",
    "#followme",
    "#fun",
    "#su",
    "#followme",
    "#follow",
    "#followforfollow",
    "#followback",
    "#followers",
    "#follow4follow",
    "#followher",
    "#follower",
    "#followhim",
    "#followall",
    "#followbackteam",
    "#followbackalways",
    "#follows",
    "#followgram",
    "#followalways",
    "#tagblender",
    "#followmefollowyou",
    "#following",
    "#followstagram",
    "#follownow",
    "#ifollowback",
    "#followus",
    "#followmeback",
    "#followforlike",
    "#followmeplease",
    "#followshoutoutlikecomment",
    "#followbackinstantly",
    "#f4f",
    "#ifollo",
    "#followyou",
    "#like4like",
    "#liking",
    "#likeall",
    "#likeforlike",
    "#likes4likes",
    "#love",
    "#instagood",
    "#tagblender",
    "#tagblender",
    "#likesforlikes",
    "#ilikeback",
    "#liketeam",
    "#liker",
    "#ilike",
    "#likealways",
    "#likebackteam",
    "#ilikeyou",
    "#ilikeit",
    "#likeme",
    "#tflers",
    "#likes",
    "#likesback",
    "#photooftheday",
    "#likesforlike",
    "#iliketurtles",
    "#likes4followers",
    "#likemebac",
    "#ilu",
    "#likesreturned",
    "#l4l",
    "#tagblender",
    "#hungry",
    "#foodgasm",
    "#instafood",
    "#instafood",
    "#yum",
    "#yummy",
    "#yumyum",
    "#delicious",
    "#eat",
    "#dinner",
    "#food",
    "#foodporn",
    "#stuffed",
    "#hot",
    "#beautiful",
    "#breakfast",
    "#lunch",
    "#love",
    "#sharefood",
    "#homemade",
    "#sweet",
    "#delicious",
    "#eating",
    "#foodpic",
    "#foodpics",
    "#amazing",
    "#instagood",
    "#photooftheday",
    "#fresh",
    "#singer",
    "#hardrock",
    "#tagblender",
    "#guitarist",
    "#pianist",
    "#musicals",
    "#rockstars",
    "#trumpet",
    "#artistic",
    "#guitar",
    "#punk",
    "#song",
    "#musician",
    "#recording",
    "#band",
    "#hiphop",
    "#classic",
    "#pop",
    "#rockstar",
    "#musicvideo",
    "#songs",
    "#onedirectioninfection",
    "#musical",
    "#festival",
    "#group",
    "#concert",
    "#bands",
    "#1d",
    "#rocknroll",
    "#rockband",
    "#art",
    "#tagblender",
    "#artist",
    "#artistic",
    "#artists",
    "#arte",
    "#dibujo",
    "#myart",
    "#artwork",
    "#illustration",
    "#graphicdesign",
    "#graphic",
    "#color",
    "#colour",
    "#colorful",
    "#painting",
    "#drawing",
    "#drawings",
    "#markers",
    "#paintings",
    "#watercolor",
    "#watercolour",
    "#ink",
    "#creative",
    "#sketch",
    "#sketchaday",
    "#pencil",
    "#cs6",
    "#photoshop",
    "#beautiful",
    "#awesome_shots",
    "#nature_shooters",
    "#vida",
    "#fauna",
    "#instagood",
    "#animales",
    "#cute",
    "#love",
    "#nature",
    "#animals",
    "#animal",
    "#pet",
    "#cat",
    "#dogs",
    "#dog",
    "#cats",
    "#photooftheday",
    "#cute",
    "#wild",
    "#animalsofinstagram",
    "#natgeohub",
    "#igs",
    "#tagblender",
    "#petstagram",
    "#petsagram",
    "#animallovers",
    "#insect",
    "#insects",
    "#creepy",
    "#nature_shooters",
    "#cats",
    "#animal",
    "#nature",
    "#kittens",
    "#catlover",
    "#life",
    "#instacat",
    "#cutie",
    "#cat",
    "#meow",
    "#pussycat",
    "#picpets",
    "#pets",
    "#kittensofinstagram",
    "#sweet",
    "#pet",
    "#tagblender",
    "#catsofinstagram",
    "#kitten",
    "#ilovemypet",
    "#petsagram",
    "#kitty",
    "#ilovecats",
    "#ilovemycat",
    "#instapets",
    "#ilovecat",
    "#catstagram",
    "#catlovers",
    "#cutecate",
    "#petstagram",
    "#dogoftheday",
    "#pet",
    "#pets",
    "#dogsofinstagram",
    "#ilovemydog",
    "#doggy",
    "#dog",
    "#cute",
    "#adorable",
    "#precious",
    "#nature",
    "#animal",
    "#animals",
    "#puppy",
    "#puppies",
    "#pup",
    "#petstagram",
    "#picpets",
    "#cutie",
    "#life",
    "#petsagram",
    "#tagblender",
    "#dogs",
    "#instagramdogs",
    "#dogstagram",
    "#ilovedog",
    "#ilovedogs",
    "#doglover",
    "#doglovers",
    "#tail",
    "#dogs",
    "#instagramdogs",
    "#dogstagram",
    "#ilovedog",
    "#ilovedogs",
    "#doglover",
    "#dogoftheday",
    "#pet",
    "#pets",
    "#dogsofinstagram",
    "#ilovemydog",
    "#doggy",
    "#dog",
    "#cute",
    "#adorable",
    "#precious",
    "#nature",
    "#animal",
    "#animals",
    "#puppy",
    "#puppies",
    "#pup",
    "#petstagram",
    "#picpets",
    "#cutie",
    "#life",
    "#petsagram",
    "#tagblender",
    "#doglovers",
    "#tail",
    "#love",
    "#instagood",
    "#photooftheday",
    "#fashion",
    "#Beautiful",
    "#like4like",
    "#picoftheday",
    "#art",
    "#happy",
    "#photography",
    "#instagram",
    "#followme",
    "#style",
    "#follow",
    "#instadaily",
    "#travel",
    "#life",
    "#cute",
    "#fitness",
    "#nature",
    "#beauty",
    "#girl",
    "#fun",
    "#photo",
    "#amazing",
    "#likeforlike",
    "#instalike",
    "#Selfie",
    "#smile",
    "#me",
    "#lifestyle",
    "#model",
    "#follow4follow",
    "#music",
    "#friends",
    "#motivation",
    "#like",
    "#food",
    "#inspiration",
    "#Repost",
    "#summer",
    "#design",
    "#makeup",
    "#TBT",
    "#followforfollow",
    "#ootd",
    "#Family",
    "#l4l",
    "#cool",
    "#igers",
    "#TagsForLikes",
    "#hair",
    "#instamood",
    "#sun",
    "#vsco",
    "#fit",
    "#beach",
    "#photographer",
    "#gym",
    "#artist",
    "#girls",
    "#vscocam",
    "#autumn",
    "#pretty",
    "#luxury",
    "#instapic",
    "#black",
    "#sunset",
    "#funny",
    "#sky",
    "#blogger",
    "#hot",
    "#healthy",
    "#work",
    "#bestoftheday",
    "#workout",
    "#f4f",
    "#nofilter",
    "#london",
    "#goals",
    "#blackandwhite",
    "#blue",
    "#swag",
    "#health",
    "#party",
    "#night",
    "#landscape",
    "#nyc",
    "#happiness",
    "#pink",
    "#lol",
    "#foodporn",
    "#newyork",
    "#fitfam",
    "#awesome",
    "#fashionblogger",
    "#Halloween",
    "#Home",
    "#fall",
    "#paris"
  ];
}

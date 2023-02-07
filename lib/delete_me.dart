import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/service/Database/firebase_db.dart';
import 'package:flutter/material.dart';

import 'common/service/uploadServices.dart';

class ImgbbConverterScreen extends StatefulWidget {
  const ImgbbConverterScreen({Key? key}) : super(key: key);

  @override
  State<ImgbbConverterScreen> createState() => _ImgbbConverterScreenState();
}

class _ImgbbConverterScreenState extends State<ImgbbConverterScreen> {
  var fStorageImages = [
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/null_Profile_2023-02-01%2015:02:25.754985?alt=media&token=bf8bee4e-97ed-4f88-acbe-d90cad4876d9",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/Jojo%20Harbater_Profile_2023-02-02%2008%3A40%3A19.297843?alt=media&token=c84cac11-8b50-4acc-af37-41e28b7235ab",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/null_Profile_2023-02-03%2017:55:56.117225?alt=media&token=0290523a-313c-45f1-8024-e19454428119",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/null_Profile_2023-01-31%2005:43:05.954554?alt=media&token=973f515b-3620-40ef-8392-733f05bd9cf7",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/null_Profile_2023-02-05%2018:00:11.305258?alt=media&token=102656f6-e4cc-4c17-916d-436e3505cd51",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/null_Profile_2023-01-29%2012:54:41.919881?alt=media&token=71dcece6-fe76-4e24-9e15-d9e87133c9a8",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/null_Profile_2023-02-06%2020:09:02.364426?alt=media&token=75f26081-7be5-498e-9d4f-3b34f09af97d",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/Adir%20Tzuri%20Cohen_Profile_2023-02-01%2017%3A57%3A53.994232?alt=media&token=d6711fa7-9217-4367-8946-e2040a8b14d5",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/%D7%91%D7%A8%20%D7%90%D7%95%D7%A4%D7%99%D7%A8_Profile_2023-01-22%2001%3A33%3A51.133890?alt=media&token=2e8df2ff-861f-4ff2-91cb-66116f9880fb",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/%D7%90%D7%92%D7%9D%20%D7%99%D7%97%D7%96%D7%A7%D7%99%D7%90%D7%A1_Profile_2023-02-03%2020%3A44%3A44.976666?alt=media&token=471b3426-18d9-4323-943d-62411e0496be",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/Almog%20Shlosberg_Profile_2023-01-28%2000%3A28%3A06.364254?alt=media&token=58117980-526b-4f62-b075-087a5cdeddd9",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/%D7%90%D7%9C%D7%95%D7%9F%20%D7%A0%D7%92%D7%A8_Profile_2023-02-01%2018%3A11%3A53.723569?alt=media&token=efe3f96b-b29e-4bd8-bb55-1a55481f80ed",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/Amelie%20Hamama_Profile_2023-02-06%2011:12:40.756182?alt=media&token=6d44df43-36e2-4921-8d10-0925c483e339",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/%D7%9B%D7%9F%20%D7%90%D7%A0%D7%99%20%D7%94%D7%96%D7%94%20%D7%9B%D7%9F_Profile_2023-02-05%2001%3A20%3A49.081370?alt=media&token=ea5102f7-84e7-4db4-9492-a377e9a182d8",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/null_Profile_2023-01-28%2014:46:00.507444?alt=media&token=93fd5dd7-1d0a-4cc2-ad43-090d912b28ac",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/%D7%90%D7%91%D7%99%D7%A2%D7%93%20%D7%A7%D7%9C%D7%9E%D7%9F_Profile_2023-02-01%2019%3A14%3A29.155245?alt=media&token=29b24c76-95e4-4e47-8eb1-604fe5eb69bf",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/%D7%90%D7%91%D7%99%D7%90%D7%9C%20%D7%9E%D7%A8%D7%A6%D7%99%D7%90%D7%A0%D7%95_Profile_2023-02-02%2017%3A18%3A00.341773?alt=media&token=b9b58ed7-aea3-41a4-925f-44403ee2953d",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/Aviv%20Zarko_Profile_2023-02-01%2015%3A03%3A29.509725?alt=media&token=00e61e76-f0bf-476c-a9b2-a1017fcc92e8",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/elcha%20Ay_Profile_2023-01-22%2001%3A34%3A10.991217?alt=media&token=a50057db-76a0-486a-b58b-6ed60a3b4843",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/%D7%9E%D7%99%D7%A7%D7%99%20%D7%9C%D7%A4%D7%99%D7%93_Profile_2023-02-01%2017%3A54%3A45.167670?alt=media&token=072bb140-5058-4bb1-996d-ba16831f5bce",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/BAHAA%20QASEM_Profile_2023-02-06%2012:44:03.367641?alt=media&token=dd564d60-9f66-4cb7-9d92-6923aaa239fe",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/Itay%20Blago_Profile_2023-01-27%2000%3A36%3A36.439054?alt=media&token=856527f6-22eb-41d1-91fd-12004ff8ff5b",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/%D7%91%D7%9F%20%D7%9C%D7%99%D7%93%D7%A8_Profile_2023-02-01%2015%3A45%3A38.227377?alt=media&token=ff9b9e0c-0910-49d9-9382-48bd96935a3c",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/null_Profile_2023-02-01%2015:37:32.544374?alt=media&token=c3e493fe-32e1-4eb3-a0d4-c11ceade624a",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/null_Profile_2023-02-06%2011:15:45.357810?alt=media&token=d5a843ce-3899-481a-b1f4-98c920600291",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/%D7%90%D7%95%D7%A8%D7%99%D7%90%D7%9C%20%D7%9C%D7%95%D7%99_Profile_2023-02-01%2015%3A56%3A22.864029?alt=media&token=4709f91f-44a9-47de-be66-2480187284a4",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/%D7%90%D7%A8%D7%99%D7%90%D7%9C%20%D7%97%D7%A8%D7%99%D7%98%D7%9F_Profile_2023-01-22%2010%3A30%3A23.336888?alt=media&token=f93baaed-1117-4f6c-bc40-263c0576811a",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/Googleplay%20Cnx_Profile_2023-01-28%2011%3A47%3A53.138566?alt=media&token=53f7879b-33cb-4afc-80ae-4ce3cdfdf421",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/amit%20cohen_Profile_2023-01-23%2014%3A10%3A00.870012?alt=media&token=76e75436-bd0c-4761-8835-c1307ff4d286",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/%D7%93%D7%91%20%D7%A0%D7%A1%D7%99%D7%9A%20%D7%94%D7%A1%D7%A8%D7%98%D7%99%D7%9D%20%D7%90%D7%95%D7%97%D7%99%D7%95%D7%9F_Profile_2023-01-29%2002%3A11%3A41.852864?alt=media&token=5df27093-e7d3-463d-a781-6153fc006995",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/Eden%20Hahamov_Profile_2023-02-06%2009:26:21.953058?alt=media&token=85dc4ad6-973b-4ee5-b361-411ef794b77c",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/Einav%20Edison_Profile_2023-02-04%2000%3A07%3A47.035378?alt=media&token=ab17fac7-5413-48b7-8d61-025c2e5790cc",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/null_Profile_2023-02-01%2016:12:55.541814?alt=media&token=446c1097-6601-4aaa-b55d-143efb52932b",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/Eliya%20Aharon_Profile_2023-02-02%2010:15:11.799514?alt=media&token=7fa898c1-5075-40f4-8b9c-0b05ed25f3ea",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/P.y.e._Profile_2023-02-06%2012%3A31%3A49.478869?alt=media&token=114fb2a2-6e4f-42b7-93f2-5b7fc41c808c",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/Yael%20Elmakayas_Profile_2023-02-02%2016%3A40%3A35.267317?alt=media&token=48d2e8f7-eaca-4f84-9109-aa12bed5932e",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/%D7%90%D7%9E%D7%99%D7%9C%20%D7%9E%D7%95%D7%A6%D7%A5%20%D7%A9%D7%9D%20%D7%9E%D7%A9%D7%A4%D7%97%D7%94_Profile_2023-02-05%2001%3A38%3A52.943127?alt=media&token=946a1f1f-b645-4705-99e4-cb035fe178ad",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/%E3%83%85PsychoMan%E3%83%85_Profile_2023-02-06%2008%3A57%3A23.649101?alt=media&token=3b4ec216-37d6-4e07-aefd-28c39dae233e",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/%D7%90%D7%A8%D7%90%D7%9C_Profile_2023-02-01%2015%3A26%3A10.243716?alt=media&token=84a66f4d-be1e-4a21-bf2e-2d341db430ed",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/%D7%90%D7%99%D7%99%D7%9C%20%D7%91%D7%99%D7%98%D7%95%D7%9F_Profile_2023-01-28%2013%3A25%3A21.599472?alt=media&token=645ee43c-c392-4383-b77f-15468669507d",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/null_Profile_2023-02-05%2010:39:32.170595?alt=media&token=346d75cd-0ccd-4da4-ad19-9868fc0d34ed",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/null_Profile_2023-02-04%2009:21:40.954551?alt=media&token=5a624602-8822-4845-ad0f-3776ba3e5f0c",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/hadar%20strul_Profile_2023-02-01%2017%3A51%3A37.954275?alt=media&token=1693f6ab-b2ef-49c0-bc83-c49f8d8646eb",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/Ahmed%20Hassan_Profile_2023-02-03%2001%3A42%3A55.263107?alt=media&token=5b858687-df24-499c-916d-139ecbad96f3",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/Hlia_Profile_2023-02-01%2019%3A18%3A02.580300?alt=media&token=c094ac73-5b32-4d20-8c5a-a01a0ec57ae6",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/hila%20saar_Profile_2023-02-04%2009:16:33.219243?alt=media&token=4cab0a04-f19b-4279-b133-d3a2e2720c0c",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/yuval%20maharshak_Profile_2023-02-01%2019%3A44%3A43.573710?alt=media&token=68ba75ff-394b-401b-9277-5fe56b4dbec7",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/The%20Biton_Profile_2023-01-21%2023%3A05%3A48.369962?alt=media&token=62ab2f84-8d74-4b7f-8e79-5f1a0bee85fc",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/idan%20yosef_Profile_2023-02-01%2015%3A18%3A24.481511?alt=media&token=4856f7b3-f0c5-40b8-8c7c-5bc798cc2bfb",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/null_Profile_2023-02-07%2016:10:36.517687?alt=media&token=2881e42f-2740-4bef-953c-0203e1f64be4",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/%D7%90%D7%99%D7%A8%D7%99%D7%A1%20%D7%99%D7%A6%D7%97%D7%A7%D7%99_Profile_2023-02-04%2000%3A17%3A28.766194?alt=media&token=a7f7c2dd-c0fa-495a-a4d8-333f2ae2035c",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/%D7%90%D7%99%D7%AA%D7%99%20%D7%90%D7%A8%D7%92%D7%A1_Profile_2023-02-01%2017:51:38.797888?alt=media&token=2d1c2082-f3fa-4497-9d57-d7465537c896",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/Jacqui%20Haggerty_Profile_2023-02-04%2017:19:09.262178?alt=media&token=930ecc50-38a9-45a4-8648-e09090b633f2",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/jack_Profile_2022-12-27%2016%3A15%3A57.229474?alt=media&token=6337ff97-b2cd-42e1-8a67-a7f175758eea",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/jemin_Profile_2022-12-27%2019%3A38%3A34.985605?alt=media&token=306ca64d-f4ab-4a99-9a57-c034bd040690",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/%D7%9C%D7%99%D7%90%D7%95%D7%A8%20%D7%90%D7%91%D7%99%D7%A1%D7%A8%D7%95%D7%A8_Profile_2023-02-01%2015%3A51%3A11.214344?alt=media&token=09367f6a-06c0-4cc5-bece-31ac93ca7b42",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/null_Profile_2023-01-29%2023:30:28.459045?alt=media&token=f811f186-036b-42eb-8b53-a884e310a9b0",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/lazy%20girl_Profile_2023-02-05%2002:42:23.745022?alt=media&token=12ab38ac-b2ac-4dcb-aab9-5e424216b60d",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/null_Profile_2023-02-03%2018:13:03.107288?alt=media&token=b0a4bbf5-cf82-49bf-b789-b526ee8554bb",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/Josh%20%D7%A9%D7%9C%D7%9E%D7%94_Profile_2023-01-28%2010%3A10%3A06.678812?alt=media&token=08731047-1398-426d-8bc2-922b05ce375d",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/Matan%20Grodzitski_Profile_2023-02-01%2017%3A55%3A58.396374?alt=media&token=b4385e18-8d33-4831-b059-202c5b7b842e",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/null_Profile_2023-02-03%2020:54:03.868661?alt=media&token=71b94228-7056-419c-b777-1056a10e664a",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/%D7%9E%D7%A0%D7%97%D7%9D%20%D7%A6%D7%99%D7%95%D7%9F%20%D7%9C%D7%A1%D7%A7%D7%A8_Profile_2023-01-29%2013%3A42%3A34.145487?alt=media&token=35730e6a-21af-4ff9-aa7e-5eafa5723723",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/Meni%20Meni_Profile_2023-02-06%2001%3A07%3A11.061590?alt=media&token=8396c06d-dd96-493c-b28f-efb3e30f7659",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/talia%20elimor_Profile_2023-02-04%2010:01:46.774150?alt=media&token=92bafe08-3c11-4902-9a24-43c174d0b761",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/%D7%99%D7%92%D7%90%D7%9C%20%D7%A8%D7%99%D7%91%D7%A7%D7%99%D7%9F_Profile_2023-01-27%2022%3A27%3A23.909122?alt=media&token=1a911dea-430d-410e-b79b-151db2a24676",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/null_Profile_2023-02-03%2023:46:16.692967?alt=media&token=ffaa1ecb-0d59-4ccd-8fb7-73e7dc7fd814",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/MR%20Felix_Profile_2023-01-22%2001%3A38%3A23.516705?alt=media&token=30344df6-165a-4128-94f4-56c7cf6096a2",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/Ms%20World_Profile_2023-01-25%2014%3A59%3A47.392706?alt=media&token=cd8ca877-ecc2-4603-b83f-cc8364d3f959",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/null_Profile_2023-02-01%2015:14:22.112910?alt=media&token=de0f2848-228b-4bc5-ba30-0b065dd31b9b",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/%D7%A0%D7%97%D7%9E%D7%9F%20%D7%90%D7%95%D7%A8%20%D7%A6%D7%91%D7%90%D7%91%D7%90_Profile_2023-02-01%2023%3A13%3A29.187558?alt=media&token=284e8b4e-6191-495b-a677-6b07781e6812",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/NERYA%20SHEETRIT_Profile_2023-02-01%2017%3A59%3A39.305960?alt=media&token=c650c7a7-d42c-497d-895b-b0c228a49e90",
    "https://i.ibb.co/098LZLm/607356c50be4.jpg",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/Noa%20Braver_Profile_2023-02-01%2017%3A49%3A03.191135?alt=media&token=80cab209-c4ce-4fa5-ab87-76ac086585b3",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/Noga%20Aviv_Profile_2023-02-06%2010%3A40%3A36.625421?alt=media&token=44ac01de-3aaa-46fc-85f3-8a6e422e1c24",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/%D7%A0%D7%92%D7%94%20%D7%93%D7%95%D7%93%20%D7%A8%D7%95%D7%91%D7%99%D7%9F_Profile_2023-02-07%2012%3A37%3A21.495112?alt=media&token=d804f0c9-9c13-4d20-b0d1-62874fe7dfc7",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/%D7%99%20%D7%99_Profile_2023-01-22%2001%3A39%3A32.646957?alt=media&token=b64afe34-fa11-4d78-828f-b65372f4c03d",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/Ofek%20Almog_Profile_2023-02-01%2019%3A04%3A56.414404?alt=media&token=874d8f83-f74f-4a75-8130-8ed61f400b5a",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/%D7%90%D7%95%D7%A4%D7%99%D7%A8%20%D7%A1%D7%92%D7%99%D7%A8_Profile_2023-02-01%2023%3A31%3A52.444998?alt=media&token=c74f2c72-37a1-45a7-9229-f7ed71519ece",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/%D7%90%D7%95%D7%A8%D7%99%20%D7%99%D7%A9%D7%A8%D7%90%D7%9C%D7%99_Profile_2023-02-01%2015%3A17%3A05.884991?alt=media&token=ec38b34c-f480-4e57-9998-63ad56f3e2d8",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/%D7%90%D7%95%D7%A8%D7%99%20%D7%A8%D7%95%D7%A0%D7%93_Profile_2023-02-01%2016%3A41%3A43.154189?alt=media&token=51d1c124-71d3-4b21-8356-8db60e4bef05",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/John%20Smith_Profile_2023-02-05%2012%3A49%3A26.505684?alt=media&token=e747bd8c-fdfd-4be8-b2f8-4575a8f2b312",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/bolA_Profile_2023-01-28%2014%3A14%3A24.675206?alt=media&token=a4cfb91c-a1ab-4603-b808-e00809de7de5",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/Rajender%20Kumar_Profile_2023-02-03%2002%3A09%3A12.096059?alt=media&token=484dbfdf-26f5-43c8-b7f2-587e735eaad3",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/null_Profile_2023-02-04%2022:13:13.414566?alt=media&token=6fb43e2c-4fb3-4a2d-8983-17448d02a9ad",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/null_Profile_2023-02-01%2018:18:03.149954?alt=media&token=280cd471-274e-48b9-b676-0d9ff67d060d",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/%D7%A8%D7%A0%D7%A9%20%D7%A9%D7%A4%D7%99%D7%A8%D7%90_Profile_2023-02-03%2020%3A00%3A19.222418?alt=media&token=35a3fc9d-7b42-488a-ab1a-879d61dd414f",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/Tal%20Melamed_Profile_2023-01-21%2021%3A38%3A54.965797?alt=media&token=118d68b0-c991-4929-a188-4d2bb379a6bf",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/RilTopia%20Team_Profile_2022-12-26%2008%3A59%3A45.173041?alt=media&token=75fa91cc-52cd-4926-8c77-3bd137a1763b",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/Roni%20Engel_Profile_2023-02-01%2016%3A27%3A30.052618?alt=media&token=c7416cf1-d8aa-4e01-bdca-a41da2c84cfe",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/null_Profile_2023-02-03%2023:03:02.952498?alt=media&token=baf3cf31-b282-419b-905c-361fc7e5dfa9",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/%D7%90%D7%92%D7%9D%20%D7%A1%D7%A2%D7%93%D7%94_Profile_2023-02-02%2011:26:54.715060?alt=media&token=8d5fc5ca-849a-4585-8bd8-30e05883582d",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/Sagi%20Thepro_Profile_2023-02-06%2019%3A33%3A18.955228?alt=media&token=00a154d8-9936-4163-a688-06949dc772fd",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/%D7%A9%D7%A7%D7%93%20%D7%A1%D7%A4%D7%A8%D7%99%D7%9D%202_Profile_2023-02-05%2018%3A01%3A27.149038?alt=media&token=0ad32869-60fa-454e-b350-fac210d2dc44",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/Shanie%20Hazan_Profile_2023-02-03%2023%3A56%3A35.904799?alt=media&token=a18d2fb6-37b4-43e9-9969-5ce0b8c88382",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/%D7%A9%D7%99%20%D7%9E%D7%93%D7%9C%D7%A1%D7%99_Profile_2023-01-29%2001%3A02%3A52.559077?alt=media&token=9cf260a2-5444-485d-890e-76f2b4a0fbe8",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/S%20B_Profile_2023-02-04%2007%3A41%3A19.304502?alt=media&token=19993a7a-91d7-4bf0-bc9d-3a1597e359aa",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/%D7%A9%D7%9E%D7%95%D7%90%D7%9C%20%D7%A2%D7%9C%D7%94_Profile_2023-02-01%2015%3A18%3A59.528692?alt=media&token=0f516d8f-a622-4497-9517-900b44c37c2b",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/shoham93_Profile_2023-02-03%2007%3A25%3A59.696547?alt=media&token=8c8b9983-8614-4301-99b5-aa6f8304ed65",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/%D7%A9%D7%95%D7%A9%D7%A0%D7%94%20%D7%9B%D7%A5_Profile_2023-02-03%2022%3A05%3A08.102447?alt=media&token=dd68acce-4b4f-4eae-91a5-74b6d04f4b83",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/Acresking_Profile_2023-02-06%2022%3A21%3A48.258506?alt=media&token=6317a1a4-186b-4115-a24e-8c0d9a83bb5f",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/null_Profile_2023-02-02%2016:21:13.636923?alt=media&token=494f349b-c494-4a99-a9cd-fbf38916559c",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/Stav%20Swim_Profile_2023-02-01%2015:04:54.329532?alt=media&token=c02a5168-926f-4e1a-a335-4576480dd684",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/%D7%A9%D7%99%20%D7%9E%D7%93%D7%9C%D7%A1%D7%99_Profile_2023-01-28%2017%3A49%3A07.713574?alt=media&token=90c3fa06-4110-4f12-8bb7-f8ae504eeea5",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/%D7%A9%D7%99%20%D7%9E%D7%93%D7%9C%D7%A1%D7%99_Profile_2023-02-04%2020%3A41%3A37.205771?alt=media&token=94c3c5bf-d18c-40b4-a1b5-5f5b947f9038",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/Tal%20Gerstel_Profile_2023-02-01%2018%3A13%3A00.152486?alt=media&token=f439bd36-600c-4404-960d-52bba8a39b67",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/djtal%20han_Profile_2023-02-01%2017:53:52.243181?alt=media&token=cac32c26-1d2a-4faa-8ce7-a81e750e695b",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/Tal%20Melamed_Profile_2023-02-04%2000%3A57%3A13.651833?alt=media&token=209d3cbf-4a71-4841-8ff8-76155dbbf3e1",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/jjj_Profile_2023-02-06%2018%3A11%3A22.512358?alt=media&token=644766a5-ab46-4401-965d-c0e8a2fe2ca8",
    "https://lh3.googleusercontent.com/a-/ACNPEu-Bub2D3f0eHMHLGUv603-vBSOcO_cTOIeIE00k=s96-c",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/SushA_Profile_2023-02-03%2022%3A23%3A48.918040?alt=media&token=86283b52-a2ac-4feb-94d5-680da457dcd8",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/TTGL%20TTGL_Profile_2023-02-03%2022%3A35%3A46.377417?alt=media&token=d72999f1-c5cf-450a-bf6b-ca18aec947b1",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/Ya'ar%20Nir_Profile_2023-02-04%2004%3A11%3A55.075062?alt=media&token=214cd0af-9459-4b0b-b1d8-f42e12f36c92",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/%D7%99%D7%A2%D7%9C%20%D7%A4%D7%95%D7%A7%D7%A1_Profile_2023-02-02%2010%3A23%3A05.756767?alt=media&token=791bfb48-2cb9-4807-ad40-89968858ed89",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/%D7%99%D7%94%D7%91%20%D7%99%D7%A9%D7%A8%D7%90%D7%9C_Profile_2023-02-01%2020%3A03%3A06.060672?alt=media&token=f5355c2a-6581-43dd-94cf-47706af9562e",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/%D7%99%D7%A2%D7%A7%D7%91%20%D7%A9%D7%98%D7%A8%D7%99%D7%AA_Profile_2023-01-22%2001%3A29%3A54.349160?alt=media&token=b9c3aaad-41b3-43e0-b793-46f4f592db99",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/Yaniv_Profile_2023-02-01%2015%3A07%3A55.383591?alt=media&token=1d6788ee-d77a-4dc8-ac8f-ae063f2c02ac",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/Yehuda%20Zeevi_Profile_2023-02-02%2017%3A31%3A37.378864?alt=media&token=8c685107-61aa-47a0-aff2-a79d8f97226c",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/Yehuda%20Peri_Profile_2023-02-02%2014%3A22%3A09.364491?alt=media&token=ecf1120a-4fdb-4598-9db9-77a76ac8bb92",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/%D7%98%D7%9C%D7%90%D7%9C%20%D7%93%D7%94%D7%9F_Profile_2023-02-06%2011%3A42%3A27.010601?alt=media&token=931c3739-c01d-496c-b718-6b9114b312ca",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/%D7%99%D7%95%D7%97%D7%A0%D7%9F%20%D7%A9%D7%9C%D7%92_Profile_2023-01-29%2013%3A52%3A19.510995?alt=media&token=6999b72d-dc49-44af-a4c4-6d10c4cdc6b5",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/Yuval%20Taub_Profile_2023-02-06%2008:19:06.865029?alt=media&token=4f3b640a-0910-407a-923d-f2b7d9f0d5ef",
    "https://firebasestorage.googleapis.com/v0/b/biton-messanger.appspot.com/o/shani%20zahavi_Profile_2023-02-01%2015%3A06%3A04.932678?alt=media&token=1aff3315-782a-4936-af61-18661a6e7408",
  ];

  var imgBbImages = [];

  @override
  void initState() {
    handleFetch();
    super.initState();
  }

  void handleFetch() async {
    print('START: handleFetch()');
    var index = 0;
    for (var link in fStorageImages) {
      print('START: fStorageImages() index: $index');
      print('link $link');
      var newLink = await UploadServices.imgbbUploadPhoto(link);
      imgBbImages.add(newLink);
      index++;
      var snap = await Database.db.collection('users').where('photoUrl', isEqualTo: link).get();
      if (snap.docs.isNotEmpty) {
        print('snap.docs.first.id ${snap.docs.first.id}');
        await Database.updateFirestore(
            collection: 'users', docName: snap.docs.first.id, toJson: {'photoUrl': '$newLink'});
        print('DONE: fStorageImages() index: $index');
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Text('\n \n \n ${imgBbImages.length} \n $imgBbImages'),
    );
  }
}

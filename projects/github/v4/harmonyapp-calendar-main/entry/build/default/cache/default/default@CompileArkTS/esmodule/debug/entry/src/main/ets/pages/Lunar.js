/*
     农历每一年，对应公历的数据
     此数据来源于互联网，原作者不详细，在此感谢
     MAPPING[0][0]：每年闰月的月份，0表示不闰
     MAPPING[0][1, 13]：表示每月初一对应的阳历时间，前两个字符表示月，后两个字符表示日
*/
let MAPPING = [
    [8, "0131", "0301", "0331", "0429", "0528", "0627", "0726", "0825", "0924", "1023", "1122", "1222", "1320"],
    [0, "0219", "0320", "0419", "0518", "0616", "0716", "0814", "0913", "1012", "1111", "1211", "1310"],
    [0, "0208", "0310", "0408", "0508", "0606", "0705", "0804", "0902", "1002", "1031", "1130", "1230"],
    [5, "0129", "0227", "0329", "0427", "0527", "0625", "0724", "0823", "0921", "1020", "1119", "1219", "1317"],
    [0, "0216", "0317", "0416", "0515", "0614", "0713", "0811", "0910", "1009", "1107", "1207", "1306"],
    [0, "0204", "0306", "0405", "0504", "0603", "0703", "0801", "0830", "0929", "1028", "1127", "1226"],
    [4, "0125", "0223", "0325", "0424", "0523", "0622", "0721", "0820", "0918", "1018", "1116", "1216", "1314"],
    [0, "0213", "0314", "0413", "0512", "0611", "0710", "0809", "0908", "1007", "1106", "1205", "1304"],
    [0, "0202", "0303", "0401", "0430", "0530", "0629", "0728", "0827", "0925", "1025", "1124", "1223"],
    [2, "0122", "0220", "0322", "0420", "0519", "0618", "0717", "0816", "0914", "1014", "1113", "1213", "1311"],
    [0, "0210", "0311", "0410", "0509", "0607", "0707", "0805", "0904", "1003", "1102", "1202", "1301"],
    [6, "0130", "0301", "0330", "0429", "0528", "0626", "0726", "0824", "0922", "1022", "1121", "1220", "1319"],
    [0, "0218", "0319", "0417", "0517", "0615", "0714", "0813", "0911", "1010", "1109", "1209", "1307"],
    [0, "0206", "0308", "0407", "0506", "0605", "0704", "0802", "0901", "0930", "1029", "1128", "1227"],
    [5, "0126", "0225", "0327", "0425", "0525", "0623", "0723", "0821", "0920", "1019", "1117", "1217", "1315"],
    [0, "0214", "0316", "0414", "0514", "0613", "0712", "0811", "0909", "1009", "1107", "1207", "1305"],
    [0, "0203", "0304", "0403", "0502", "0601", "0630", "0730", "0829", "0927", "1027", "1125", "1225"],
    [2, "0123", "0222", "0323", "0421", "0521", "0619", "0719", "0818", "0916", "1016", "1115", "1214", "1313"],
    [0, "0211", "0313", "0411", "0510", "0609", "0708", "0807", "0905", "1005", "1104", "1203", "1302"],
    [7, "0201", "0302", "0401", "0430", "0529", "0628", "0727", "0825", "0924", "1024", "1122", "1222", "1321"],
    [0, "0220", "0320", "0419", "0518", "0616", "0716", "0814", "0912", "1012", "1110", "1210", "1309"],
    [0, "0208", "0310", "0408", "0508", "0606", "0705", "0804", "0902", "1001", "1031", "1129", "1229"],
    [5, "0128", "0227", "0328", "0427", "0527", "0625", "0724", "0823", "0921", "1020", "1119", "1218", "1317"],
    [0, "0216", "0317", "0416", "0516", "0614", "0714", "0812", "0911", "1010", "1108", "1208", "1306"],
    [0, "0205", "0305", "0404", "0504", "0602", "0702", "0801", "0830", "0929", "1028", "1127", "1226"],
    [4, "0124", "0223", "0324", "0423", "0522", "0621", "0721", "0819", "0918", "1018", "1116", "1216", "1314"],
    [0, "0213", "0314", "0412", "0512", "0610", "0710", "0808", "0907", "1007", "1105", "1205", "1304"],
    [0, "0202", "0304", "0402", "0501", "0531", "0629", "0729", "0827", "0926", "1025", "1124", "1224"],
    [2, "0123", "0221", "0322", "0420", "0519", "0618", "0717", "0815", "0914", "1013", "1112", "1212", "1311"],
    [0, "0210", "0311", "0410", "0509", "0607", "0707", "0805", "0903", "1003", "1101", "1201", "1231"],
    [6, "0130", "0228", "0330", "0429", "0528", "0626", "0726", "0824", "0922", "1022", "1120", "1220", "1319"],
    [0, "0217", "0319", "0418", "0517", "0616", "0715", "0814", "0912", "1011", "1110", "1209", "1308"],
    [0, "0206", "0307", "0406", "0506", "0604", "0704", "0802", "0901", "0930", "1029", "1128", "1227"],
    [5, "0126", "0224", "0326", "0425", "0524", "0623", "0722", "0821", "0920", "1019", "1118", "1217", "1315"],
    [0, "0214", "0315", "0414", "0513", "0612", "0712", "0810", "0909", "1008", "1107", "1207", "1305"],
    [0, "0204", "0305", "0403", "0503", "0601", "0701", "0730", "0829", "0928", "1027", "1126", "1226"],
    [3, "0124", "0223", "0323", "0421", "0521", "0619", "0718", "0817", "0916", "1015", "1114", "1214", "1313"],
    [0, "0211", "0313", "0411", "0510", "0609", "0708", "0806", "0905", "1004", "1103", "1203", "1302"],
    [7, "0131", "0302", "0401", "0430", "0529", "0628", "0727", "0825", "0924", "1023", "1122", "1222", "1320"],
    [0, "0219", "0321", "0420", "0519", "0617", "0717", "0815", "0913", "1013", "1111", "1211", "1309"],
    [0, "0208", "0309", "0408", "0507", "0606", "0705", "0804", "0902", "1001", "1031", "1129", "1229"],
    [6, "0127", "0226", "0328", "0426", "0526", "0625", "0724", "0823", "0921", "1020", "1119", "1218", "1317"],
    [0, "0215", "0317", "0415", "0515", "0614", "0713", "0812", "0910", "1010", "1108", "1208", "1306"],
    [0, "0205", "0306", "0405", "0504", "0603", "0702", "0801", "0831", "0929", "1029", "1127", "1227"],
    [4, "0125", "0224", "0324", "0423", "0522", "0621", "0720", "0819", "0917", "1017", "1116", "1215", "1314"],
    [0, "0213", "0314", "0412", "0512", "0610", "0709", "0808", "0906", "1006", "1105", "1205", "1303"],
    [0, "0202", "0304", "0402", "0501", "0531", "0629", "0728", "0827", "0925", "1025", "1124", "1223"],
    [2, "0122", "0221", "0323", "0421", "0520", "0619", "0718", "0816", "0915", "1014", "1113", "1212", "1311"],
    [0, "0210", "0311", "0409", "0509", "0607", "0707", "0805", "0903", "1003", "1101", "1201", "1230"],
    [7, "0129", "0228", "0329", "0428", "0528", "0626", "0726", "0824", "0922", "1022", "1120", "1220", "1318"],
    [0, "0217", "0318", "0417", "0517", "0615", "0715", "0814", "0912", "1011", "1110", "1209", "1308"],
    [0, "0206", "0308", "0406", "0506", "0605", "0704", "0803", "0901", "1001", "1030", "1129", "1228"],
    [5, "0127", "0225", "0326", "0424", "0524", "0622", "0722", "0820", "0919", "1019", "1117", "1217", "1315"],
    [0, "0214", "0315", "0414", "0513", "0611", "0711", "0810", "0908", "1008", "1107", "1206", "1305"],
    [0, "0203", "0305", "0403", "0503", "0601", "0630", "0730", "0828", "0927", "1027", "1126", "1225"],
    [3, "0124", "0222", "0324", "0422", "0522", "0620", "0719", "0818", "0916", "1016", "1114", "1214", "1313"],
    [0, "0212", "0312", "0411", "0510", "0609", "0708", "0806", "0905", "1004", "1103", "1203", "1301"],
    [8, "0131", "0302", "0331", "0430", "0529", "0628", "0727", "0825", "0924", "1023", "1122", "1221", "1320"],
    [0, "0218", "0320", "0419", "0519", "0617", "0717", "0815", "0913", "1013", "1111", "1211", "1309"],
    [0, "0208", "0309", "0408", "0508", "0606", "0706", "0804", "0903", "1002", "1101", "1130", "1230"],
    [6, "0128", "0227", "0327", "0426", "0525", "0624", "0724", "0822", "0921", "1020", "1119", "1218", "1317"],
    [0, "0215", "0317", "0415", "0515", "0613", "0713", "0811", "0910", "1010", "1108", "1208", "1306"],
    [0, "0205", "0306", "0405", "0504", "0602", "0702", "0731", "0830", "0929", "1028", "1127", "1227"],
    [4, "0125", "0224", "0325", "0424", "0523", "0621", "0721", "0819", "0918", "1017", "1116", "1216", "1315"],
    [0, "0213", "0314", "0412", "0512", "0610", "0709", "0808", "0906", "1006", "1104", "1204", "1303"],
    [0, "0202", "0303", "0402", "0501", "0531", "0629", "0728", "0827", "0925", "1024", "1123", "1223"],
    [3, "0121", "0220", "0322", "0421", "0520", "0619", "0718", "0816", "0915", "1014", "1112", "1212", "1311"],
    [0, "0209", "0311", "0410", "0509", "0608", "0708", "0806", "0904", "1004", "1102", "1202", "1231"],
    [7, "0130", "0228", "0329", "0427", "0527", "0626", "0725", "0824", "0922", "1022", "1120", "1220", "1318"],
    [0, "0217", "0318", "0417", "0516", "0615", "0714", "0813", "0912", "1011", "1110", "1209", "1308"],
    [0, "0206", "0308", "0406", "0505", "0604", "0703", "0802", "0901", "0930", "1030", "1129", "1228"],
    [5, "0127", "0225", "0327", "0425", "0524", "0623", "0722", "0821", "0919", "1019", "1118", "1218", "1316"],
    [0, "0215", "0315", "0414", "0513", "0611", "0711", "0809", "0908", "1007", "1106", "1206", "1304"],
    [0, "0203", "0305", "0403", "0503", "0601", "0630", "0730", "0828", "0926", "1026", "1125", "1224"],
    [4, "0123", "0222", "0324", "0422", "0522", "0620", "0719", "0818", "0916", "1015", "1114", "1214", "1312"],
    [0, "0211", "0313", "0412", "0511", "0610", "0709", "0807", "0906", "1005", "1103", "1203", "1301"],
    [8, "0131", "0301", "0331", "0429", "0529", "0627", "0727", "0825", "0924", "1023", "1121", "1221", "1319"],
    [0, "0218", "0320", "0418", "0518", "0617", "0716", "0815", "0913", "1013", "1111", "1211", "1309"],
    [0, "0207", "0309", "0407", "0507", "0606", "0705", "0804", "0902", "1002", "1101", "1130", "1230"],
    [6, "0128", "0227", "0328", "0426", "0526", "0624", "0724", "0823", "0921", "1021", "1120", "1219", "1318"],
    [0, "0216", "0317", "0415", "0514", "0613", "0712", "0811", "0909", "1009", "1108", "1207", "1306"],
    [0, "0205", "0306", "0405", "0504", "0602", "0702", "0731", "0829", "0928", "1028", "1126", "1226"],
    [4, "0125", "0224", "0325", "0424", "0523", "0621", "0721", "0819", "0917", "1017", "1115", "1215", "1314"],
    [0, "0213", "0315", "0413", "0513", "0611", "0710", "0809", "0907", "1006", "1105", "1204", "1303"],
    [10, "0202", "0303", "0401", "0501", "0531", "0629", "0728", "0827", "0925", "1024", "1123", "1222", "1321"],
    [0, "0220", "0321", "0420", "0520", "0618", "0718", "0816", "0915", "1014", "1112", "1212", "1310"],
    [0, "0209", "0310", "0409", "0509", "0607", "0707", "0806", "0904", "1004", "1102", "1202", "1231"],
    [6, "0129", "0228", "0329", "0428", "0527", "0626", "0726", "0824", "0923", "1023", "1121", "1221", "1319"],
    [0, "0217", "0318", "0416", "0516", "0614", "0714", "0812", "0911", "1011", "1109", "1209", "1308"],
    [0, "0206", "0308", "0406", "0505", "0604", "0703", "0802", "0831", "0930", "1029", "1128", "1228"],
    [5, "0127", "0225", "0327", "0425", "0524", "0623", "0722", "0820", "0919", "1018", "1117", "1217", "1316"],
    [0, "0215", "0316", "0415", "0514", "0612", "0712", "0810", "0908", "1008", "1106", "1206", "1305"],
    [0, "0204", "0304", "0403", "0503", "0601", "0630", "0730", "0828", "0926", "1026", "1124", "1224"],
    [3, "0123", "0221", "0323", "0422", "0521", "0620", "0719", "0818", "0916", "1015", "1114", "1213", "1312"],
    [0, "0210", "0312", "0411", "0511", "0609", "0709", "0807", "0906", "1005", "1103", "1203", "1301"],
    [8, "0131", "0301", "0331", "0430", "0529", "0628", "0727", "0826", "0925", "1024", "1122", "1222", "1320"],
    [0, "0219", "0319", "0418", "0517", "0616", "0715", "0814", "0912", "1012", "1111", "1211", "1309"],
    [0, "0207", "0309", "0407", "0507", "0605", "0705", "0803", "0902", "1002", "1031", "1130", "1230"],
    [5, "0128", "0227", "0328", "0426", "0526", "0624", "0723", "0822", "0921", "1020", "1119", "1219", "1317"],
    [0, "0216", "0318", "0416", "0515", "0614", "0713", "0811", "0910", "1009", "1108", "1208", "1307"],
    [0, "0205", "0306", "0405", "0504", "0602", "0702", "0731", "0829", "0928", "1027", "1126", "1226"],
    [4, "0124", "0223", "0325", "0423", "0523", "0621", "0721", "0819", "0917", "1017", "1115", "1215", "1313"],
    [0, "0212", "0314", "0413", "0512", "0611", "0710", "0809", "0907", "1006", "1105", "1204", "1303"],
    [0, "0201", "0303", "0402", "0501", "0531", "0630", "0729", "0828", "0926", "1025", "1124", "1223"],
    [2, "0122", "0220", "0321", "0419", "0519", "0618", "0717", "0816", "0914", "1014", "1112", "1212", "1310"],
    [0, "0209", "0310", "0409", "0508", "0607", "0706", "0805", "0904", "1003", "1102", "1201", "1231"],
    [7, "0129", "0228", "0329", "0428", "0527", "0626", "0725", "0824", "0922", "1022", "1121", "1220", "1319"],
    [0, "0218", "0319", "0417", "0517", "0615", "0714", "0813", "0911", "1011", "1110", "1210", "1308"],
    [0, "0207", "0308", "0406", "0505", "0604", "0703", "0801", "0831", "0929", "1029", "1128", "1227"],
    [5, "0126", "0225", "0327", "0425", "0524", "0623", "0722", "0820", "0919", "1018", "1117", "1216", "1315"],
    [0, "0214", "0316", "0414", "0514", "0612", "0712", "0810", "0908", "1008", "1106", "1206", "1304"],
    [0, "0203", "0305", "0403", "0503", "0602", "0701", "0731", "0829", "0927", "1027", "1125", "1225"],
    [4, "0123", "0222", "0322", "0421", "0521", "0619", "0719", "0817", "0916", "1015", "1114", "1213", "1312"],
    [0, "0210", "0312", "0410", "0510", "0608", "0708", "0807", "0905", "1005", "1103", "1203", "1301"],
    [9, "0131", "0301", "0331", "0429", "0529", "0627", "0727", "0825", "0924", "1024", "1122", "1222", "1320"],
    [0, "0219", "0320", "0419", "0518", "0616", "0716", "0814", "0913", "1013", "1112", "1211", "1310"],
    [0, "0208", "0309", "0407", "0507", "0605", "0704", "0803", "0901", "1001", "1031", "1129", "1229"],
    [6, "0128", "0226", "0328", "0426", "0526", "0624", "0723", "0822", "0920", "1020", "1118", "1218", "1317"],
    [0, "0216", "0317", "0416", "0515", "0614", "0713", "0811", "0910", "1009", "1108", "1207", "1306"],
    [0, "0205", "0307", "0405", "0505", "0603", "0703", "0801", "0830", "0929", "1028", "1126", "1226"],
    [4, "0125", "0223", "0324", "0423", "0523", "0621", "0721", "0819", "0917", "1017", "1115", "1215", "1313"],
    [0, "0212", "0313", "0412", "0512", "0610", "0710", "0808", "0907", "1006", "1105", "1204", "1303"],
    [0, "0201", "0303", "0401", "0501", "0530", "0629", "0729", "0827", "0926", "1025", "1124", "1223"],
    [2, "0122", "0220", "0322", "0420", "0519", "0618", "0718", "0816", "0915", "1015", "1113", "1213", "1311"],
    [0, "0210", "0310", "0409", "0508", "0606", "0706", "0804", "0903", "1003", "1101", "1201", "1231"],
    [6, "0129", "0228", "0329", "0428", "0527", "0625", "0725", "0823", "0922", "1021", "1120", "1220", "1319"],
    [0, "0217", "0319", "0417", "0517", "0615", "0714", "0813", "0911", "1010", "1109", "1209", "1308"],
    [0, "0206", "0308", "0407", "0506", "0605", "0704", "0802", "0901", "0930", "1029", "1128", "1228"],
    [5, "0126", "0225", "0326", "0425", "0524", "0623", "0722", "0820", "0919", "1018", "1116", "1216", "1315"],
    [0, "0213", "0315", "0414", "0513", "0612", "0711", "0810", "0908", "1008", "1106", "1205", "1304"],
    [0, "0203", "0304", "0403", "0502", "0601", "0701", "0730", "0829", "0927", "1027", "1125", "1225"],
    [3, "0123", "0221", "0323", "0422", "0521", "0620", "0719", "0818", "0917", "1016", "1115", "1214", "1313"],
    [0, "0211", "0312", "0410", "0509", "0608", "0707", "0806", "0905", "1004", "1103", "1203", "1301"],
    [7, "0131", "0301", "0331", "0429", "0528", "0627", "0726", "0825", "0923", "1023", "1122", "1222", "1320"],
    [0, "0219", "0320", "0419", "0518", "0616", "0716", "0814", "0913", "1012", "1111", "1211", "1309"],
    [0, "0208", "0310", "0408", "0508", "0606", "0705", "0804", "0902", "1001", "1031", "1130", "1229"],
    [6, "0128", "0227", "0328", "0426", "0526", "0624", "0723", "0822", "0920", "1019", "1118", "1217", "1316"],
    [0, "0215", "0317", "0416", "0515", "0614", "0713", "0811", "0910", "1009", "1107", "1207", "1305"],
    [0, "0204", "0306", "0405", "0504", "0603", "0702", "0801", "0830", "0929", "1028", "1126", "1226"],
    [5, "0124", "0223", "0325", "0423", "0523", "0622", "0721", "0820", "0918", "1018", "1116", "1216", "1314"],
    [0, "0212", "0313", "0411", "0511", "0610", "0709", "0808", "0906", "1006", "1105", "1204", "1303"],
    [0, "0201", "0302", "0401", "0430", "0530", "0628", "0728", "0827", "0925", "1025", "1124", "1223"],
    [2, "0122", "0220", "0322", "0420", "0519", "0618", "0717", "0816", "0914", "1014", "1113", "1212", "1311"],
    [0, "0210", "0311", "0410", "0509", "0607", "0707", "0805", "0903", "1003", "1102", "1201", "1231"],
    [7, "0130", "0229", "0329", "0428", "0527", "0625", "0725", "0823", "0921", "1021", "1119", "1219", "1318"],
    [0, "0217", "0319", "0417", "0517", "0615", "0714", "0813", "0911", "1010", "1109", "1208", "1307"],
    [0, "0206", "0308", "0406", "0506", "0604", "0704", "0802", "0901", "0930", "1029", "1128", "1227"],
    [5, "0126", "0225", "0326", "0425", "0525", "0623", "0723", "0821", "0920", "1019", "1117", "1217", "1315"],
    [0, "0214", "0314", "0413", "0513", "0611", "0711", "0810", "0908", "1008", "1106", "1205", "1304"],
    [0, "0202", "0304", "0402", "0502", "0531", "0630", "0730", "0828", "0927", "1027", "1125", "1225"],
    [3, "0123", "0221", "0323", "0421", "0521", "0619", "0719", "0817", "0916", "1016", "1114", "1214", "1313"],
    [0, "0211", "0313", "0411", "0510", "0609", "0708", "0806", "0905", "1005", "1103", "1203", "1302"],
    [8, "0201", "0301", "0331", "0429", "0528", "0627", "0726", "0824", "0923", "1022", "1121", "1221", "1320"],
    [0, "0219", "0320", "0419", "0518", "0616", "0716", "0814", "0912", "1012", "1110", "1210", "1309"],
    [0, "0208", "0309", "0408", "0508", "0606", "0705", "0804", "0902", "1001", "1031", "1129", "1229"],
    [6, "0128", "0226", "0328", "0427", "0526", "0625", "0724", "0823", "0921", "1020", "1119", "1218", "1317"],
    [0, "0215", "0316", "0415", "0515", "0613", "0713", "0811", "0910", "1009", "1107", "1207", "1305"],
    [0, "0204", "0305", "0404", "0504", "0602", "0702", "0731", "0830", "0929", "1028", "1126", "1226"],
    [4, "0124", "0223", "0324", "0423", "0522", "0621", "0720", "0819", "0918", "1017", "1116", "1216", "1314"],
    [0, "0212", "0314", "0412", "0512", "0610", "0710", "0808", "0907", "1006", "1105", "1205", "1304"],
    [0, "0202", "0303", "0401", "0501", "0530", "0628", "0727", "0826", "0924", "1024", "1123", "1223"],
    [3, "0121", "0220", "0322", "0420", "0519", "0618", "0717", "0815", "0914", "1013", "1112", "1212", "1311"],
    [0, "0209", "0311", "0410", "0509", "0607", "0707", "0805", "0903", "1003", "1101", "1201", "1231"],
    [7, "0129", "0228", "0330", "0428", "0528", "0626", "0726", "0824", "0922", "1022", "1120", "1220", "1318"],
    [0, "0217", "0318", "0417", "0516", "0615", "0714", "0813", "0911", "1010", "1109", "1208", "1307"],
    [0, "0205", "0307", "0406", "0505", "0604", "0704", "0802", "0901", "0930", "1029", "1128", "1227"],
    [5, "0126", "0224", "0326", "0424", "0524", "0623", "0722", "0821", "0919", "1019", "1117", "1217", "1315"],
    [0, "0214", "0315", "0414", "0513", "0612", "0711", "0810", "0909", "1008", "1107", "1206", "1305"],
    [0, "0203", "0304", "0402", "0502", "0531", "0629", "0729", "0828", "0926", "1026", "1125", "1224"],
    [4, "0123", "0221", "0323", "0421", "0521", "0619", "0718", "0817", "0915", "1015", "1114", "1214", "1312"],
    [0, "0211", "0312", "0411", "0510", "0609", "0708", "0806", "0905", "1004", "1103", "1203", "1301"],
    [8, "0131", "0302", "0331", "0430", "0529", "0628", "0727", "0825", "0924", "1023", "1122", "1221", "1320"],
    [0, "0219", "0320", "0418", "0518", "0616", "0716", "0814", "0912", "1012", "1110", "1210", "1308"],
    [0, "0207", "0309", "0407", "0507", "0605", "0704", "0803", "0901", "0930", "1030", "1128", "1228"],
    [6, "0126", "0225", "0326", "0425", "0525", "0623", "0723", "0821", "0920", "1019", "1118", "1217", "1316"],
    [0, "0214", "0316", "0414", "0514", "0612", "0712", "0811", "0909", "1009", "1107", "1207", "1305"],
    [0, "0204", "0304", "0403", "0502", "0601", "0630", "0730", "0828", "0927", "1027", "1125", "1225"],
    [0, "0123", "0222", "0323", "0422", "0521", "0620", "0719", "0818", "0917", "1017", "1115", "1215"],
    [0, "0113", "0212", "0313", "0412", "0511", "0609", "0709", "0807", "0906", "1006", "1104", "1204"],
    [0, "0103", "0201", "0303", "0401", "0501", "0530", "0628", "0728", "0826", "0925", "1024", "1123"],
    [3, "1223", "0122", "0220", "0321", "0419", "0519", "0617", "0716", "0815", "0913", "1012", "1111", "1211"],
    [0, "0110", "0208", "0310", "0409", "0508", "0607", "0706", "0804", "0903", "1002", "1031", "1130"],
    [7, "1230", "0128", "0227", "0329", "0428", "0527", "0625", "0725", "0823", "0922", "1021", "1119", "1219"],
    [0, "0118", "0216", "0318", "0417", "0516", "0615", "0714", "0813", "0911", "1011", "1109", "1209"],
    [0, "0107", "0206", "0306", "0405", "0504", "0603", "0703", "0801", "0831", "0929", "1029", "1127"],
    [5, "1227", "0125", "0224", "0325", "0423", "0523", "0622", "0721", "0820", "0919", "1018", "1117", "1216"],
    [0, "0115", "0213", "0315", "0413", "0512", "0611", "0710", "0809", "0908", "1007", "1106", "1206"],
    [0, "0104", "0203", "0304", "0403", "0502", "0531", "0630", "0729", "0828", "0926", "1026", "1125"],
    [4, "1225", "0123", "0222", "0322", "0421", "0520", "0618", "0718", "0816", "0914", "1014", "1113", "1213"],
    [0, "0111", "0210", "0312", "0410", "0510", "0608", "0707", "0806", "0904", "1003", "1102", "1202"],
    [8, "1231", "0130", "0301", "0331", "0429", "0529", "0627", "0726", "0825", "0923", "1022", "1121", "1221"],
    [0, "0119", "0218", "0320", "0418", "0518", "0616", "0716", "0814", "0913", "1012", "1110", "1210"],
    [0, "0108", "0207", "0308", "0406", "0506", "0605", "0704", "0803", "0901", "1001", "1030", "1129"],
    [6, "1228", "0126", "0225", "0327", "0425", "0525", "0623", "0723", "0822", "0920", "1020", "1118", "1218"],
    [0, "0116", "0214", "0316", "0414", "0514", "0612", "0712", "0811", "0909", "1009", "1108", "1207"],
    [0, "0106", "0204", "0306", "0404", "0503", "0602", "0701", "0731", "0829", "0928", "1028", "1127"],
    [4, "1226", "0125", "0223", "0324", "0422", "0521", "0620", "0719", "0817", "0916", "1016", "1115", "1214"],
    [0, "0113", "0212", "0313", "0412", "0511", "0609", "0709", "0807", "0905", "1005", "1104", "1203"],
    [0, "0102", "0201", "0303", "0401", "0501", "0530", "0628", "0727", "0826", "0924", "1024", "1122"],
    [2, "1222", "0121", "0220", "0321", "0420", "0520", "0618", "0717", "0816", "0914", "1013", "1112", "1211"] //2099
];
export class Lunar {
    // 计算公历两个日期之差
    // left：新日期，right：旧日期，interval：返回的单位 (如 y 表示以年为单位)
    solarDiff(left, right, interval) {
        let span = left.getTime() - right.getTime(); // 计算两个日期相差的毫秒数
        switch (interval) {
            case "y": return left.getFullYear() - right.getFullYear(); // 年份之差
            case "M": return (left.getFullYear() - right.getFullYear()) * 12 + (left.getMonth() - right.getMonth()); // 月份之差
            case "d": return Math.ceil(span / 1000 / 60 / 60 / 24); // 天数之差
            case "w": return Math.floor(span / 1000 / 60 / 60 / 24 / 7); // 周数之差
            case "h": return Math.floor(span / 1000 / 60 / 60); // 小时之差
            case "m": return Math.floor(span / 1000 / 60); // 分钟之差
            case "s": return Math.floor(span / 1000); // 秒数之差
            case "ms": return span; // 毫秒数之差
        }
        return 0;
    }
    // 找到农历。isPreYear：是否为农历前一年的对应数据
    findLunar(solarDate, index, minMonth, maxMonth, isPreYear) {
        let mapping = MAPPING[index];
        if (!mapping)
            return false; // 如果找不到对应年份的农历数据，返回false
        let year = solarDate.getFullYear();
        let month = solarDate.getMonth() + 1; // 实际月，从1开始，要加1
        let day = solarDate.getDate();
        let lunarYear = year;
        let lunarMonth, find, solarMonth;
        let segMonth, segDay;
        // 逆序查找农历日期
        for (let i = mapping.length - 1; i > 0; i--) {
            lunarMonth = i;
            // @ts-ignore
            segMonth = Number(mapping[i].substring(0, 2));
            // @ts-ignore
            segDay = Number(mapping[i].substring(2, 4));
            solarMonth = isPreYear && segMonth > 12 ? segMonth - 12 : segMonth;
            // 判断是否找到对应的农历日期
            find = solarMonth < month ||
                (solarMonth == month && segDay <= day) ||
                ((segMonth <= minMonth || segMonth >= maxMonth) && isPreYear);
            if ((solarMonth == 12 && solarMonth > month && i == 1)) {
                find = true;
                year--;
            }
            ;
            if (find)
                break;
        }
        // 如果找到对应农历日期，则赋值
        if (!find)
            return false;
        // 调整农历年份，取前一年
        if (isPreYear && segMonth == 12)
            year = year - 1;
        lunarYear = isPreYear ? lunarYear - 1 : lunarYear;
        return {
            year: year,
            month: solarMonth,
            day: segDay,
            lunarYear: lunarYear,
            lunarMonth: lunarMonth,
            leapMonth: mapping[0] // 闰月
        };
    }
    // 将公历日期转换为农历日期
    solarToLunar(solarDate) {
        // 计算年份偏移量，确定在MAPPING中的索引位置
        let solarYear = solarDate.getFullYear();
        let yearOffset = solarYear - 1900;
        // 检查年份偏移量是否在有效范围内
        if (yearOffset < 0 || yearOffset >= MAPPING.length) {
            throw new Error('Specified date range is invalid.');
        }
        // 查找指定公历日期对应的农历日期
        let lunarDate = this.findLunar(solarDate, yearOffset, 0, 13, false);
        // 如果未找到，尝试查找前一年的数据
        lunarDate = lunarDate || this.findLunar(solarDate, yearOffset - 1, 12, 99, true);
        // 如果仍未找到，表示超出数据范围
        if (!lunarDate)
            return false;
        // 计算农历日期中的天数偏移量，从而计算农历日
        let firstDayOfLunarMonth = new Date(lunarDate.year, lunarDate.month - 1, lunarDate.day);
        let lunarDay = this.solarDiff(solarDate, firstDayOfLunarMonth, "d") + 1;
        // 判断是否为闰月
        let lunarMonth = lunarDate.leapMonth > 0 && lunarDate.lunarMonth > lunarDate.leapMonth ? lunarDate.lunarMonth - 1 : lunarDate.lunarMonth;
        let isLeapMonth = lunarDate.leapMonth > 0 && lunarDate.leapMonth + 1 === lunarDate.lunarMonth;
        // 返回转换后的农历日期对象
        let lunarResult = {
            isLeapMonth: isLeapMonth,
            lunarYear: lunarDate.lunarYear,
            lunarMonth: lunarMonth,
            lunarDay: lunarDay,
            leapMonth: lunarDate.leapMonth
        };
        return lunarResult;
    }
    // 获取农历月份的名称
    monthName(month, leap) {
        let monthName = "正,二,三,四,五,六,七,八,九,十,冬,腊".split(",");
        return (leap ? "闰" : "") + monthName[month - 1] + "月";
    }
    // 获取农历天的名称
    dayName(lunar) {
        switch (lunar) {
            case 10: return '初十';
            case 20: return '二十';
            case 30: return '三十';
            default: return ("初十廿".split("")[Math.floor(lunar / 10)] +
                "一二三四五六七八九十".split("")[(lunar - 1) % 10]) || lunar;
        }
    }
    // 格式化农历信息
    lunarFormat(lunarResult, type) {
        switch (type) {
            case "M": return this.monthName(lunarResult.lunarMonth, lunarResult.isLeapMonth); // 传统农历月份名称
            case "D": return this.dayName(lunarResult.lunarDay); // 农历天名称
        }
    }
}
//# sourceMappingURL=Lunar.js.map
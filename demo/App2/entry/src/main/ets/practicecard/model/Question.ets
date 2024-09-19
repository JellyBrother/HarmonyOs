export interface Question {
  word: string; //单词
  sentence: string; //例句
  options: string[]; //选项
  answer: string; //答案
}

//题库
export const questionData: Question[] = [
  {
    word: "book",
    options: ["书籍", "笔", "橡皮", "背包"],
    answer: "书籍",
    sentence: "I love to read a good book every night."
  },
  {
    word: "computer",
    options: ["电视", "电脑", "手机", "相机"],
    answer: "电脑",
    sentence: "I use the computer for work and entertainment."
  },
  {
    word: "apple",
    options: ["香蕉", "桃子", "梨", "苹果"],
    answer: "苹果",
    sentence: "She enjoys eating a crisp apple in the afternoon."
  },
  {
    word: "sun",
    options: ["月亮", "太阳", "星星", "地球"],
    answer: "太阳",
    sentence: "The sun provides warmth and light to our planet."
  },
  {
    word: "summer",
    options: ["春天", "夏天", "秋天", "冬天"],
    answer: "夏天",
    sentence: "They went swimming at the beach in the hot summer sun."
  },
  {
    word: "glasses",
    options: ["眼镜", "太阳镜", "望远镜", "放大镜"],
    answer: "眼镜",
    sentence: "She wore glasses to help her see better."
  },
  {
    word: "planet",
    options: ["星球", "月球", "地球", "火星"],
    answer: "星球",
    sentence: "Earth is the third planet from the sun in our solar system."
  },
  {
    word: "water",
    options: ["火", "土地", "风", "水"],
    answer: "水",
    sentence: "I always carry a bottle of water with me."
  },
  {
    word: "mountain",
    options: ["沙漠", "海洋", "平原", "山"],
    answer: "山",
    sentence: "The mountain range is covered in snow during winter."
  },
  {
    word: "flower",
    options: ["树木", "草地", "花", "灌木"],
    answer: "花",
    sentence: "The garden is filled with colorful flowers."
  },
  {
    word: "car",
    options: ["自行车", "飞机", "船", "汽车"],
    answer: "汽车",
    sentence: "I drive my car to work every day."
  },
  {
    word: "time",
    options: ["空间", "时钟", "日历", "时间"],
    answer: "时间",
    sentence: "Time flies when you're having fun."
  },
  {
    word: "music",
    options: ["画", "舞蹈", "音乐", "戏剧"],
    answer: "音乐",
    sentence: "Listening to music helps me relax."
  },
  {
    word: "rain",
    options: ["雪", "雷电", "阳光", "雨"],
    answer: "雨",
    sentence: "I enjoy the sound of rain tapping on the window."
  },
  {
    word: "fire",
    options: ["冰", "火焰", "烟雾", "闪电"],
    answer: "火焰",
    sentence: "The campfire warmed us on a chilly evening."
  },
  {
    word: "friend",
    options: ["陌生人", "邻居", "家人", "朋友"],
    answer: "朋友",
    sentence: "A true friend is always there for you."
  },
  {
    word: "food",
    options: ["水果", "蔬菜", "肉", "食物"],
    answer: "食物",
    sentence: "Healthy food is essential for a balanced diet."
  },
  {
    word: "color",
    options: ["黑色", "白色", "红色", "颜色"],
    answer: "颜色",
    sentence: "The artist used a vibrant color palette."
  },
  {
    word: "bookshelf",
    options: ["椅子", "桌子", "书架", "床"],
    answer: "书架",
    sentence: "The bookshelf is filled with novels and reference books."
  },
  {
    word: "school",
    options: ["公园", "商店", "医院", "学校"],
    answer: "学校",
    sentence: "Students go to school to learn and grow."
  },
  {
    word: "shoes",
    options: ["帽子", "衣服", "裤子", "鞋子"],
    answer: "鞋子",
    sentence: "She bought a new pair of stylish shoes."
  },
  {
    word: "camera",
    options: ["电视", "电脑", "相机", "手机"],
    answer: "相机",
    sentence: "The photographer captured the moment with his camera."
  },
  {
    word: "dog",
    options: ["猫", "狗", "兔子", "鸟"],
    answer: "狗",
    sentence: "The dog wagged its tail happily."
  },
  {
    word: "beach",
    options: ["山峰", "海滩", "河流", "森林"],
    answer: "海滩",
    sentence: "They had a picnic on the sandy beach."
  },
  {
    word: "pencil",
    options: ["钢笔", "铅笔", "彩色笔", "毛笔"],
    answer: "铅笔",
    sentence: "She used a pencil to sketch the outline."
  },
  {
    word: "tree",
    options: ["草", "花", "树", "灌木"],
    answer: "树",
    sentence: "The old oak tree provided shade in the park."
  },
  {
    word: "phone",
    options: ["手机", "电话", "对讲机", "传呼机"],
    answer: "手机",
    sentence: "He checked his phone for messages regularly."
  },
  {
    word: "cake",
    options: ["面包", "蛋糕", "饼干", "甜点"],
    answer: "蛋糕",
    sentence: "They celebrated with a delicious cake."
  },
  {
    word: "bird",
    options: ["猫", "鸟", "老鼠", "兔子"],
    answer: "鸟",
    sentence: "The bird sang sweetly in the morning."
  },
  {
    word: "watch",
    options: ["手表", "墨镜", "项链", "戒指"],
    answer: "手表",
    sentence: "She wore a stylish watch on her wrist."
  },
  {
    word: "sunflower",
    options: ["玫瑰", "向日葵", "郁金香", "水仙"],
    answer: "向日葵",
    sentence: "The sunflower turned towards the sun."
  }, {
  word: "coffee",
  options: ["茶", "咖啡", "牛奶", "果汁"],
  answer: "咖啡",
  sentence: "She savored the aroma of freshly brewed coffee."
},
  {
    word: "pen",
    options: ["铅笔", "钢笔", "圆珠笔", "毛笔"],
    answer: "钢笔",
    sentence: "He signed the contract with a silver pen."
  },
  {
    word: "rainbow",
    options: ["雨", "彩虹", "风", "太阳"],
    answer: "彩虹",
    sentence: "After the rain, a beautiful rainbow appeared in the sky."
  },
  {
    word: "umbrella",
    options: ["雨靴", "雨伞", "雨衣", "雨帽"],
    answer: "雨伞",
    sentence: "She opened her umbrella to shield from the rain."
  },
  {
    word: "guitar",
    options: ["吉他", "小提琴", "钢琴", "笛子"],
    answer: "吉他",
    sentence: "He strummed the guitar to play a soothing melody."
  },
  {
    word: "bicycle",
    options: ["汽车", "自行车", "摩托车", "公交车"],
    answer: "自行车",
    sentence: "She rode her bicycle to the park."
  },
  {
    word: "birthday",
    options: ["圣诞节", "生日", "情人节", "万圣节"],
    answer: "生日",
    sentence: "They celebrated her birthday with a special cake."
  },
  {
    word: "elephant",
    options: ["大象", "狮子", "长颈鹿", "犀牛"],
    answer: "大象",
    sentence: "The elephant sprayed itself with water using its trunk."
  },
  {
    word: "house",
    options: ["公寓", "别墅", "平房", "小屋"],
    answer: "别墅",
    sentence: "Their beautiful house had a large garden."
  },
  {
    word: "butterfly",
    options: ["蜜蜂", "蝴蝶", "蚂蚁", "蜗牛"],
    answer: "蝴蝶",
    sentence: "The colorful butterfly fluttered among the flowers."
  },
  {
    word: "football",
    options: ["篮球", "足球", "乒乓球", "棒球"],
    answer: "足球",
    sentence: "He enjoys playing football with his friends."
  },
  {
    word: "moon",
    options: ["太阳", "星星", "月亮", "地球"],
    answer: "月亮",
    sentence: "The moonlit night was enchanting."
  },
  {
    word: "garden",
    options: ["花园", "果园", "菜园", "公园"],
    answer: "花园",
    sentence: "She spent her evenings in the peaceful garden."
  },
  {
    word: "piano",
    options: ["小提琴", "钢琴", "吉他", "笛子"],
    answer: "钢琴",
    sentence: "The melody from the piano filled the room."
  },
  {
    word: "chocolate",
    options: ["巧克力", "糖果", "冰淇淋", "蛋糕"],
    answer: "巧克力",
    sentence: "She indulged in a piece of rich, dark chocolate."
  },
  {
    word: "teacher",
    options: ["医生", "老师", "警察", "工人"],
    answer: "老师",
    sentence: "The teacher inspired her students with knowledge."
  },
  {
    word: "ocean",
    options: ["湖泊", "海洋", "河流", "池塘"],
    answer: "海洋",
    sentence: "They admired the vastness of the ocean."
  },
  {
    word: "library",
    options: ["学校", "超市", "图书馆", "医院"],
    answer: "图书馆",
    sentence: "She borrowed some books from the library to read."
  },
  {
    word: "map",
    options: ["地图", "罗盘", "放大镜", "尺子"],
    answer: "地图",
    sentence: "He used the map to find his way through the city."
  },
  {
    word: "river",
    options: ["湖泊", "河流", "海洋", "池塘"],
    answer: "河流",
    sentence: "The river flowed gently through the valley."
  }, {
  word: "fruit",
  options: ["水果", "蔬菜", "肉类", "主食"],
  answer: "水果",
  sentence: "She enjoys a variety of fresh fruit every day."
},
  {
    word: "bowl",
    options: ["碗", "杯子", "盘子", "筷子"],
    answer: "碗",
    sentence: "She served the soup in a ceramic bowl."
  },
  {
    word: "fireworks",
    options: ["烟花", "烟火", "火炮", "礼花"],
    answer: "烟花",
    sentence: "They watched the colorful fireworks light up the night sky."
  },
  {
    word: "painting",
    options: ["绘画", "雕塑", "摄影", "陶艺"],
    answer: "绘画",
    sentence: "The art gallery displayed a beautiful painting."
  },
  {
    word: "desk",
    options: ["桌子", "椅子", "书架", "沙发"],
    answer: "桌子",
    sentence: "She organized her stationery on the desk."
  },
  {
    word: "star",
    options: ["太阳", "月亮", "星星", "行星"],
    answer: "星星",
    sentence: "They gazed at the twinkling stars in the night sky."
  },
  {
    word: "candle",
    options: ["蜡烛", "香炉", "火炬", "灯笼"],
    answer: "蜡烛",
    sentence: "She lit a scented candle to create a cozy atmosphere."
  },
  {
    word: "puzzle",
    options: ["拼图", "纸牌", "棋盘", "积木"],
    answer: "拼图",
    sentence: "They spent hours solving the challenging puzzle."
  },
  {
    word: "cloud",
    options: ["风", "雨", "云", "雪"],
    answer: "云",
    sentence: "The fluffy white cloud drifted lazily across the sky."
  },
]

//从题库中随机抽取n个题目
export function getRandomQuestions(count: number) {
  let length = questionData.length;

  let indexes: number[] = [];
  while (indexes.length < count) {
    let index = Math.floor(Math.random() * length);
    if (!indexes.includes(index)) {
      indexes.push(index)
    }
  }
  return indexes.map(index => questionData[index])
}
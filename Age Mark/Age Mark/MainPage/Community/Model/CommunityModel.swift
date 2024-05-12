//
//  CommunityModel.swift
//  Age Mark
//
//  Created by 张佳乔 on 2023/9/8.
//

import UIKit

class CommunityModel: NSObject {
    private var photoArray: NSArray! // 图片数组
    private var photoHeightArray: NSMutableArray! // 图片高度数组
    
    public var itemNameArray: NSArray = [] // 每个item名字
    public var itemInfo: NSMutableDictionary! // item信息
    
    // 初始化Model
    override init() {
        super.init()
        
        photoArray = NSArray(objects: "Mask group-1", "Mask group-2", "Mask group-3", "Mask group-4", "Mask group-5", "Mask group-6", "Mask group-7", "Mask group-8", "Mask group-9", "Mask group-10")
        photoHeightArray = NSMutableArray()
        
        for photoName in photoArray {
            let tempImage = UIImage(named: photoName as! String)
            let photoHeight = ((UIScreen.main.bounds.width - 80) / 2) * (tempImage!.size.height / tempImage!.size.width)
            photoHeightArray.add((photoHeight != nil) ? photoHeight : 100 as CGFloat)
        }
        
        // 初始化各个item内容
        setupMonumentsInfo()
    }
    
    // 返回图片String
    public func photoStringWithArray(_ index: Int) -> String {
        return self.photoArray[index] as! String
    }
    
    // 返回图片Height
    public func photoHeightWithArray(_ index: Int) -> CGFloat {
        return self.photoHeightArray[index] as! CGFloat
    }
    
    // 初始化各个item内容
    private func setupMonumentsInfo() {
        
        // 初始化每个item名字，表明相应索引位的信息，映射 itemInfo 字典中的 info
        itemNameArray = NSArray(objects: "古希腊神庙", "神社", "自由女神像", "悬空寺", "长城", "白金汉宫", "全英草地网球俱乐部", "威斯敏斯特宫")
        
        itemInfo = NSMutableDictionary()
        
        let palaceOfWestminster: MonumentsInfo = MonumentsInfo()
        palaceOfWestminster.name = "威斯敏斯特宫"
        palaceOfWestminster.describe = """
    威斯敏斯特宫（英语：Palace of Westminster），又称英国议会大厦（Houses of Parliament），是位于英国伦敦威斯敏斯特城，英国议会（包括上议院和下议院）的所在地。威斯敏斯特宫及周边区域的掌控权几个世纪以来属于英国君主的代理人：掌礼大臣。1965年，通过与王室达成协议，上下两院获得控制权。但也依然有个别纪念厅室继续由掌礼大臣管理。

    威斯敏斯特宫坐落在泰晤士河北岸，接近白厅范围内的其他政府建筑物。威斯敏斯特宫是哥德复兴式建筑的代表作之一，1987年被列为世界文化遗产。西北角的钟楼就是著名的大本钟所在地。名字源自邻近的威斯敏斯特修道院。

    在1834年发生的火灾几乎将原有的威斯敏斯特宫完全烧毁，今天的宫殿于1830年代开始由建筑师查尔斯·巴里爵士和他的助手奥古斯塔斯·普金设计完成，并在此后进行了30余年的施工，该建筑包括约1,100个独立房间、100座楼梯和4.8公里长的走廊。建筑面积为112,476平方米（1,210,680平方英尺），尽管今天的宫殿基本上由19世纪重修而来，但依然保留了初建时的许多历史遗迹，如威斯敏斯特厅（Westminster Hall，可追溯至1097年）。

    自20世纪开始，威斯敏斯特宫进行过陆续的修缮，同时也经历多次破坏，包括在二战期间曾遭到德军轰炸，导致部分建筑结构受损，在战后则陆续进行过维修和小规模的结构调整。至今，威斯敏斯特宫被视为英国政治的关键中心之一，“威斯敏斯特宫”已成为英国议会和英国政府的代名词，更它已成为伦敦和整个英国的标志性地标，是该市最受欢迎的旅游景点之一，自1970年起，威斯敏斯特宫已成为受保护一级建筑，自1987年起成为联合国教科文组织世界遗产的一部分。
"""
        palaceOfWestminster.photoArray = ["palace_westminster_1", "palace_westminster_2", "palace_westminster_3", "palace_westminster_4", "palace_westminster_5"]
        itemInfo?.setValue(palaceOfWestminster, forKey: palaceOfWestminster.name)
        
        let tennisClub: MonumentsInfo = MonumentsInfo()
        tennisClub.name = "全英草地网球俱乐部"
        tennisClub.describe = """
    全英草地网球和槌球俱乐部（英语：All England Lawn Tennis and Croquet Club）是一个位在英国伦敦温布尔登的一个私人运动俱乐部，是温布尔登网球锦标赛的举办场地。此俱乐部一开始只是一群业余选手在夏天时比赛的场地，此赛事的冠军比俱乐部本身更为知名，然而目前依然以俱乐部的形式营运。

    2012年夏季奥林匹克运动会的网球比赛亦选址于全英俱乐部举行，有异于温布尔登网球锦标赛的是，主办方不会依随前者规定选手须穿上白色衣着，也是全英俱乐部首次不限制选手衣着颜色作赛。

    此俱乐部有375个正式会员，100个临时会员，还有一些过去温布尔登单打冠军的荣誉会员。会员可享有购买温布尔登两张每日赛事的票。
"""
        tennisClub.photoArray = ["tennis_club_1", "tennis_club_2", "tennis_club_3", "tennis_club_4", "tennis_club_5"]
        itemInfo?.setValue(tennisClub, forKey: tennisClub.name)
        
        let buckinghamPalace: MonumentsInfo = MonumentsInfo()
        buckinghamPalace.name = "白金汉宫"
        buckinghamPalace.describe = """
    白金汉宫（英语：Buckingham Palace、英国 /ˈbʌkɪŋəm/)是一座位于英国伦敦的皇家寝宫，也是英国君主的行政总部。是英国君主位于伦敦的主要寝宫及办公处。宫殿坐落在大伦敦威斯敏斯特城，是国家庆典和王室欢迎礼举行场地之一，也是一处重要的旅游景点。在英国历史上的欢庆或危机时刻，白金汉宫也是一处重要的集会场所。

    1703年至1705年，白金汉和诺曼比公爵约翰·谢菲尔德在此兴建了一处大型镇厅建筑“白金汉屋”，构成了今天的主体建筑，1761年，乔治三世获得该府邸，并作为一处私人寝宫。此后宫殿的扩建工程持续超过了75年，主要由建筑师约翰·纳什和爱德华·布罗尔主持，为中央庭院构筑了三侧建筑。1837年，维多利亚女王登基后，白金汉宫成为英王正式宫寝。

    19世纪末20世纪初，宫殿公共立面修建，形成延续至今日白金汉宫的形象。第二次世界大战期间，宫殿礼拜堂遭一枚德国炸弹袭击而毁；在其址上建立的女王画廊于1962年向公众开放，展示皇家收藏等相关收藏品。现在的白金汉宫对外开放参观，每天清晨都会进行著名的禁卫军交接典礼，成为英国王室文化的一大景观。当前宫殿设有775间房间，其中花园是伦敦最大的私人花园。用于官方和国家娱乐活动的国事厅于每年8月和9月的大部分时间，以及冬季和春季的某些日子向公众开放。
"""
        buckinghamPalace.photoArray = ["buckingham_palace_1", "buckingham_palace_2", "buckingham_palace_3", "buckingham_palace_4", "buckingham_palace_5"]
        itemInfo?.setValue(buckinghamPalace, forKey: buckinghamPalace.name)
        
        let greatWall: MonumentsInfo = MonumentsInfo()
        greatWall.name = "长城"
        greatWall.describe = """
    长城（蒙古语：ᠴᠠᠭᠠᠨ ᠬᠡᠷᠡᠮ，西里尔字母：Цагаан хэрэм；满语：ᡧᠠᠩᡤᡳᠶᠠᠨ ᠵᠠᠰᡝ，穆麟德转写：šanggiyanjase），是中国古代为抵御不同时期塞北游牧帝国或部落联盟的侵袭，在西北方所修筑规模浩大的隔离墙或军事工程的统称。长城虽为城墙，但不做为完全单一条绝对隔离线，而是多层检查通行的边防口，实际上还主动发挥指导经贸交流的两手策略，东西段与前后关卡加总起来可绵延上万华里（约4500-6000千米），因此又称作万里长城。

    现存的长城遗迹主要为始建于14世纪的明长城，西起嘉峪关，东至虎山长城，长城遗址跨越吉林、辽宁、北京、天津、山西、陕西、宁夏、甘肃等15个省市自治区，总计有43,721处长城遗产，长城也是自人类文明以来最巨大的建筑物。1961年起，一批长城重要点段被陆续公布为全国重点文物保护单位。1987年，长城被联合国教科文组织列为世界文化遗产，该遗产目前不仅包含上述15个省、市、自治区境内的长城，还额外包括了湖南和四川境内的苗疆长城（南长城）等。

    2012年，中国国家文物局完成了长城资源认定工作，将春秋战国至明朝等各时代修筑的长城墙体、敌楼、壕堑、关隘、城堡以及烽火台等相关历史遗存认定为长城资源，将其他具备长城特征的文化遗产纳入《长城保护条例》的保护范畴。根据认定结论，各时代长城资源分布于北京、天津、河北、山西、内蒙古、辽宁、吉林、黑龙江、山东、河南、陕西、甘肃、青海、宁夏、新疆15个省（自治区、直辖市）404个县（市/区）。认定数据如下：各类长城资源遗存总数43,721处（座/段），其中墙体10,051段，壕堑/界壕1,764段，单体建筑29,510座，关、堡2,211座，其他遗存185处。墙壕遗存总长度21,196.18千米。
"""
        greatWall.photoArray = ["Great_Wall_1", "Great_Wall_2", "Great_Wall_3", "Great_Wall_4", "Great_Wall_5"]
        itemInfo?.setValue(greatWall, forKey: greatWall.name)
        
        let hangingTemple: MonumentsInfo = MonumentsInfo()
        hangingTemple.name = "悬空寺"
        hangingTemple.describe = """
    悬空寺，位于中国山西省大同市浑源县，是一座儒释道三教合一的寺庙。该寺始建于北魏年间，现存建筑均为明清时期重建。整座寺庙建于翠峰山的半山腰上，依靠27根木梁支撑全部寺庙主要建筑，远看形如悬在半空，故名悬空寺。整座寺庙共有40间房屋，为木质框架式结构，主体建筑之间由走廊和栈道相连。1982年，悬空寺被列为全国重点文物保护单位。

    悬空寺的创建历史有不同说法。一种称该寺始建于北魏太和十五年（491年），是由北魏孝文帝拓跋宏下令建造的，原意是将天师道长寇谦之的天师道场迁移至此。悬空寺建成时原名为玄空阁，后因为“悬”和“玄”谐音，以及寺庙建在了悬崖的半山腰处，遂被称为悬空寺。另一说法称北魏道武帝拓跋圭在天兴元年（398年）攻克北燕后，从中山北归平城，发兵万人凿开恒岭，通直到五百余里，此处为始基。宋朝杨业镇守三关，也屯兵于此。还有传说称悬空寺为南宋时所建，却没有确凿证据佐证。

    在金代之前，悬空寺已经成为了儒释道三教合一的寺庙，将孔子、老子、释迦牟尼三位合供于寺院的最高处。该寺庙于金朝、明朝、以及清朝同治年间均有重修，现存建筑大多为明清时期重建。
"""
        hangingTemple.photoArray = ["Hanging_Temple_1", "Hanging_Temple_2", "Hanging_Temple_3", "Hanging_Temple_4", "Hanging_Temple_5"]
        itemInfo?.setValue(hangingTemple, forKey: hangingTemple.name)
        
        let shintoShrine: MonumentsInfo = MonumentsInfo()
        shintoShrine.name = "神社"
        shintoShrine.describe = """
    神社（神社，jinja，古语：shinsha，意思是：“神的地方”）是一种建筑，其主要目的是容纳（“供奉”）一个或多个神，即神灵。神道教。

    本殿（本殿，意为“正殿”）是供奉神社守护神的地方。如果神社矗立在神山、圣树或其他可以直接崇拜的物体上或附近，或者神社拥有类似祭坛的结构（称为祭坛），则御本殿可能不存在。Himorogi，或者一种被认为能够吸引灵魂的物体，称为“ yorishiro”，它也可以作为与神灵的直接联系。可能还有拝殿和其他建筑物 。

    虽然英语中只使用一个词（“神社”），但在日语中，神道教神社可能带有许多不同的、非等效名称中的任何一种，例如gongen、-gū、jinja、jingū、mori、myōjin、-sha、taisha、ubusuna或yashiro。路边偶尔会发现微型神社（hokora ）。大型神社有时在其院内设有微型神社，摂社或末社。神轿，即在节日（祭）期间抬在柱子上的轿子，也供奉着神，因此被视为神社。

    公元927年，《延喜式》颁布。这部著作列出了当时现存的全部 2,861 座神社，以及 3,131 座官方认可并供奉的神明。 1972年，文化厅统计神社数量为79,467座，大部分隶属于神本社庁。有些神社，例如靖国神社，完全独立于任何外部权威。日本神社的数量估计约为 10 万座。

    自古以来，社家家族通过世袭地位统治着神社，有些神社的世袭继承制度一直延续到了今天。
"""
        shintoShrine.photoArray = ["Shinto_Shrine_1", "Shinto_Shrine_2", "Shinto_Shrine_3", "Shinto_Shrine_4", "Shinto_Shrine_5"]
        itemInfo?.setValue(shintoShrine, forKey: shintoShrine.name)
        
        
        let ancientGreekTemple: MonumentsInfo = MonumentsInfo()
        ancientGreekTemple.name = "古希腊神庙"
        ancientGreekTemple.describe = """
    希腊神庙（古希腊语：ὁ ναός，ho naós，“居所”；语义有别于拉丁文templum以及英文“temple”（“神庙、寺庙、庙宇”），也名为希腊神殿。

    在古希腊宗教中的希腊圣所内是为安座众神神像的神圣建筑结构。神庙内部不是做为集会的空间，因为奉献给诸尊神明的供奉与仪式是在神庙外面举行得。神庙常常必须使用到祈愿奉献物。在希腊建筑中祂们是具有很重要的地位以及很广泛普及的建筑形式。

    此外西亚以及北非在希腊化时代中的王国，一座神庙搭建完成的宗教意向通常是为了延续遵循着当地的文化传统。甚至连在当地的一个希腊人所受到当地文化的影响力也是明显可见得，像这样的建筑结构一般认为是与希腊神庙分属不同的建筑系统。

    这些不同于希腊神庙建筑采纳的典范方面，譬如说，关于希腊─帕提亚以及巴克特里亚的神庙即是，或是关于埃及托勒密时代的神庙之典范，埃及托勒密时代的神庙祂是遵循古埃及宗教的传统。还有一个重点是很多传统的希腊神庙方位都是朝向着东方的天象。
"""
        ancientGreekTemple.photoArray = ["Ancient_Greek_Temple_1", "Ancient_Greek_Temple_2", "Ancient_Greek_Temple_3", "Ancient_Greek_Temple_4", "Ancient_Greek_Temple_5"]
        itemInfo?.setValue(ancientGreekTemple, forKey: ancientGreekTemple.name)
        
        let statueOfLiberty: MonumentsInfo = MonumentsInfo()
        statueOfLiberty.name = "自由女神像"
        statueOfLiberty.describe = """
    自由女神像（英语：Statue of Liberty）又名自由照耀世界（英语：Liberty Enlightening the World，法语：La Liberté éclairant le monde），是位于美国纽约港自由岛的巨型古典主义塑像，由弗雷德里克·奥古斯特·巴托尔迪设计，古斯塔夫·埃菲尔建造，1886年10月28日落成，是法国人民送给美国人民的礼物。塑像人物是身穿长袍的女子，代表罗马神话中的自主神，她右手高举火炬，左手的册子上用罗马数字写有美国独立宣言签署日期：“JULY IV MDCCLXXVI”（1776年7月4日），脚下还有断裂的锁链。这座塑像是自由和美国的象征，也是对外来移民的欢迎信号。

    法国法学教授和政治家爱德华·勒内·德·拉布莱曾于1865年提议，法国和美国人民应该共同制作美国独立纪念品，他的构想可能是为纪念南北战争以北军胜利、奴隶制寿终正寝结束。巴托尔迪正是受拉布莱启发而开始设计塑像，但由于当时法国的政治形势陷入困境，因此塑像建造工作直到19世纪70年代初才展开。1875年，拉布莱提出法国为塑像注资，美国提供场地并制造底座。巴托尔迪在雕塑设计完成前就做好头部和高举火炬的手臂，这些部分还在国际博览会上宣传展出。

    1876年，神像举起火炬的手臂在费城百年博览会展出，再从1876到1882年在纽约麦迪逊广场展出。筹款的进展非常缓慢，其中又以美国为甚，到1885年时，底座的建设仍然受到缺乏资金的威胁。《纽约世界报》出版商约瑟夫·普立兹发起捐款，虽然大部分捐献金额都不到一美元，但吸引了超过12万人捐助，这一项目才得以完成。塑像在法国建成，再装船跋涉重洋运抵当时的贝德罗岛，装到已经完成的底座上。塑像完成之际，纽约举行了历史上的首次纸带游行，美国总统格罗弗·克利夫兰主持了落成仪式。

    自由女神像起初由美国灯塔委员会负责管理，1901年管理权移交战争部，1933年，美国国家公园管理局开始负责塑像的维护和管理工作。1938年的大部分时间里，塑像都因翻新工程暂停向公众开放。1980年代初，塑像出现严重老化，必须加以重大修复，因此塑像于1984年至1986年关闭，将火炬和大部分内部结构替换。2001年的九一一袭击事件后，塑像出于安全和保安方面原因再度关闭，其底座于2004年重新开放，而塑像则直到2009年才开放，还对能够登上王冠的游客人数设了限制。包括底座和地基在内的整座塑像之后又关闭了一年，直到2012年10月28日再度开放，目的是安装辅助楼梯等安全保障设备，自由岛在这期间一直保持开放。不过就在塑像重新开放次日，自由岛因飓风桑迪的影响导致关闭，于2013年7月4日再次开放。出于安全方面考量，火炬周围的阳台自1916年起就不再面向公众开放。
"""
        statueOfLiberty.photoArray = ["Statue_Of_Liberty_1", "Statue_Of_Liberty_2", "Statue_Of_Liberty_3", "Statue_Of_Liberty_4", "Statue_Of_Liberty_5"]
        itemInfo?.setValue(statueOfLiberty, forKey: statueOfLiberty.name)
        
    }
}

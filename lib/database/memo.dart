

// 버전 업그레이드로 코드 수정, https://pub.dev/packages/sqflite sql도우미 참고

final String TableName = 'memos';
final String id_='_id';
final String title_='_title' ;
final String text_='_text' ;
final String createTime_ = '_createTime' ;
final String editTime_='editTime' ;

class Memo{

  // 1. 모델 구현
  int id ;
   String title ;
   String text ;
   String createTime ;
    String editTime ;

  Memo();

  Map<String, Object > toMap() { // key 와 value 매핑

    var map = <String, Object>{

      title_ : title,
      text_ : text,
      createTime_ : createTime,
      editTime_ : editTime
    };
    if(id != null) map[id_] = id;

    return map;
  }

  Memo.fromMap(Map<String, Object> map){
    id = map[id_];
    title = map[title_];
    text = map[text_];
    createTime = map[createTime_];
    editTime = map[editTime_];
  }
}
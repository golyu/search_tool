class CodeBean {
  static final int TYPE_SEARCH = 1; // 查询
  static final int TYPE_OPEN = 2; // 开通
  static final int TYPE_CLOSE = 3; // 关闭

  String code; // 代码
  String title; // 标题
  String description; // 说明
  int type; // 类型 1查询2开通3关闭
  String operator; // 运营商

  CodeBean();

  CodeBean.smart(this.code, this.type, this.title, this.description) {
    this.operator = "smart";
  }
}

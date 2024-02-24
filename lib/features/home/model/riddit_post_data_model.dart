class RidditPostsDataModel {
  String? subreddit;
  String? selftext;
  String? authorFullname;
  bool? saved;
  bool? clicked;
  String? title;
  String? subredditNamePrefixed;
  String? linkFlairCssClass;
  String? name;
  String? linkFlairTextColor;
  String? authorFlairBackgroundColor;
  String? linkFlairText;
  String? thumbnail;
  String? authorFlairCssClass;
  String? postHint;
  String? subredditType;
  String? authorFlairType;
  String? domain;
  String? selftextHtml;
  String? urlOverriddenByDest;
  String? linkFlairTemplateId;
  String? authorFlairText;
  String? subredditId;
  String? linkFlairBackgroundColor;
  String? id;
  String? author;
  String? whitelistStatus;
  String? authorFlairTextColor;
  String? permalink;
  String? parentWhitelistStatus;
  String? url;
  num? created;

  RidditPostsDataModel({
    this.subreddit,
    this.selftext,
    this.authorFullname,
    this.saved,
    this.clicked,
    this.title,
    this.subredditNamePrefixed,
    this.linkFlairCssClass,
    this.name,
    this.linkFlairTextColor,
    this.authorFlairBackgroundColor,
    this.linkFlairText,
    this.thumbnail,
    this.authorFlairCssClass,
    this.postHint,
    this.subredditType,
    this.authorFlairType,
    this.domain,
    this.selftextHtml,
    this.urlOverriddenByDest,
    this.linkFlairTemplateId,
    this.authorFlairText,
    this.subredditId,
    this.linkFlairBackgroundColor,
    this.id,
    this.author,
    this.whitelistStatus,
    this.authorFlairTextColor,
    this.permalink,
    this.parentWhitelistStatus,
    this.url,
    this.created,
  });

  RidditPostsDataModel.fromJson(Map<String, dynamic> json) {
    subreddit = json['subreddit'];
    selftext = json['selftext'];
    authorFullname = json['author_fullname'];
    saved = json['saved'];
    clicked = json['clicked'];
    title = json['title'];
    created = json['created'];
    subredditNamePrefixed = json['subreddit_name_prefixed'];
    linkFlairCssClass = json['link_flair_css_class'];
    name = json['name'];
    linkFlairTextColor = json['link_flair_text_color'];
    authorFlairBackgroundColor = json['author_flair_background_color'];
    linkFlairText = json['link_flair_text'];
    thumbnail = json['thumbnail'];
    authorFlairCssClass = json['author_flair_css_class'];
    postHint = json['post_hint'];
    subredditType = json['subreddit_type'];
    authorFlairType = json['author_flair_type'];
    domain = json['domain'];
    selftextHtml = json['selftext_html'];
    urlOverriddenByDest = json['url_overridden_by_dest'];
    linkFlairTemplateId = json['link_flair_template_id'];
    authorFlairText = json['author_flair_text'];
    subredditId = json['subreddit_id'];
    linkFlairBackgroundColor = json['link_flair_background_color'];
    id = json['id'];
    author = json['author'];
    whitelistStatus = json['whitelist_status'];
    authorFlairTextColor = json['author_flair_text_color'];
    permalink = json['permalink'];
    parentWhitelistStatus = json['parent_whitelist_status'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subreddit'] = subreddit;
    data['selftext'] = selftext;
    data['author_fullname'] = authorFullname;
    data['saved'] = saved;
    data['clicked'] = clicked;
    data['title'] = title;
    data['subreddit_name_prefixed'] = subredditNamePrefixed;
    data['link_flair_css_class'] = linkFlairCssClass;
    data['name'] = name;
    data['link_flair_text_color'] = linkFlairTextColor;
    data['author_flair_background_color'] = authorFlairBackgroundColor;
    data['link_flair_text'] = linkFlairText;
    data['thumbnail'] = thumbnail;
    data['author_flair_css_class'] = authorFlairCssClass;
    data['post_hint'] = postHint;
    data['subreddit_type'] = subredditType;
    data['author_flair_type'] = authorFlairType;
    data['domain'] = domain;
    data['selftext_html'] = selftextHtml;
    data['url_overridden_by_dest'] = urlOverriddenByDest;
    data['link_flair_template_id'] = linkFlairTemplateId;
    data['author_flair_text'] = authorFlairText;
    data['subreddit_id'] = subredditId;
    data['created'] = created;
    data['link_flair_background_color'] = linkFlairBackgroundColor;
    data['id'] = id;
    data['author'] = author;
    data['whitelist_status'] = whitelistStatus;
    data['author_flair_text_color'] = authorFlairTextColor;
    data['permalink'] = permalink;
    data['parent_whitelist_status'] = parentWhitelistStatus;
    data['url'] = url;
    return data;
  }
}

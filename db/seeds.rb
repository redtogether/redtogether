u_test = User.create!(
  email: "test@red.together",
  password: "redtogether",
  handle: "test_user"
)
u_test.confirm!

###########################################

c_decarceration = Channel.create!(
  name: "Decarceration",
  title: "+Decarceration",
  description: "Build the People, Not the Prisons!"
)

c_test = Channel.create!(
  name: "TestMachine",
  title: "+TestMachine: please ignore",
  description: "For test purposes only!"
)

##########################################

u_test.subscribe(c_decarceration)
u_test.subscribe(c_test)

##########################################

p_obsolete = Post.create!(
  channel: c_decarceration,
  user: u_test,
  title: "Are Prisons Obsolete? by Angela Y. Davis",
  body: "https://web.archive.org/web/20150912064844/http://www.feministes-radicales.org/wp-content/uploads/2010/11/Angela-Davis-Are_Prisons_Obsolete.pdf"
)

p_new_jc = Post.create!(
  channel: c_decarceration,
  user: u_test,
  title: "The New Jim Crow by Michelle Alexander",
  body: "https://libcom.org/library/new-jim-crow-mass-incarceration-age-colorblindness-michelle-alexander"
)

p_discipline = Post.create!(
  channel: c_decarceration,
  user: u_test,
  title: "Discipline and Punish by Michel Foucault",
  body: "https://libcom.org/library/discipline-punish-birth-prison-michel-foucault"
)

p_forced = Post.create!(
  channel: c_decarceration,
  user: u_test,
  title: "African Americans' Forced Labor by Heather Ann Thompson",
  body: "https://solidarity-us.org/node/2941"
)

p_cost = Post.create!(
  channel: c_decarceration,
  user: u_test,
  title: "The Real Cost of Building and Financing Prisons and Jails",
  body: "http://www.realcostofprisons.org/papers-finance.html"
)

p_test = Post.create!(
  channel: c_test,
  user: u_test,
  title: "Yet Another Test Post!",
  body: "https://www.loc.gov/"
)

##########################

c_wow = Comment.create!(
  post: p_obsolete,
  author: u_test,
  body: "Wow!"
)

c_wow_resp = Comment.create!(
  post: p_obsolete,
  author: u_test,
  parent: c_wow,
  body: "Response to \"Wow!\""
)

c_wow_resp_resp = Comment.create!(
  post: p_obsolete,
  author: u_test,
  parent: c_wow_resp,
  body: "A response to \"A response to \"Wow\"\""
)

c_wow_resp = Comment.create!(
  post: p_obsolete,
  author: u_test,
  parent: c_wow,
  body: "Another response to \"Wow\""
)

c_tl2 = Comment.create!(
  post: p_obsolete,
  author: u_test,
  body: "A second top-level comment"
)
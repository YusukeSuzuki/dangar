import dangar.handlers;
import vibe.d;

URLRouter dangarRouter()
{
	auto router = new URLRouter;
	auto fsettings = new HTTPFileServerSettings;

	fsettings.serverPathPrefix = "/static";

	router.
		get("/", &getLayoutedPage!"index.dt").
		get("/static/*", serveStaticFiles("public/", fsettings)).
		get("/create_user", &getLayoutedPage!"create_user.dt").
		get("/login", &getLayoutedPage!"login.dt").
		get("/logout", &logout).
		post("/actions/create_user", &createUser).
		post("/actions/login", &login).
		post("/actions/logout", &logout).
		get("*", &getLayoutedPage!"index.dt")
		;

	return router;
}

struct User
{
	string name;
	bool loggedIn;
}

void getLayoutedPage(string template_file)(HTTPServerRequest req, HTTPServerResponse res)
{
	string name = "not logged in";
	User user = {"", false};

	if(req.session && req.session.isKeySet("username"))
	{
		user.name = req.session.get!(string)("username");
		user.loggedIn = true;
	}

	res.render!(template_file, user);
}

/*
void hello(HTTPServerRequest req, HTTPServerResponse res)
{
	res.writeBody("Hello, World! Fuck'n hot!");
}

void getForm(HTTPServerRequest req, HTTPServerResponse res)
{
	res.render!("form_test.dt");
}

void getVersion(HTTPServerRequest req, HTTPServerResponse res)
{
	res.writeBody("0.0.1");
}

void getJSON(HTTPServerRequest req, HTTPServerResponse res)
{
	res.contentType("application/json");
	auto j = Json.emptyObject;
	j.name = "Example";
	j.id = 1;
	res.writeBody(j.toString());
}
*/


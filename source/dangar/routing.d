import danger.handlers;

import vibe.d;

URLRouter dangarRouter()
{
	auto router = new URLRouter;
	router.
		get("/version", &getVersion).
		get("/json", &getJSON).
		get("*", &hello);

	return router;
}

void hello(HTTPServerRequest req, HTTPServerResponse res)
{
	res.writeBody("Hello, World! Fuck'n hot!");
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


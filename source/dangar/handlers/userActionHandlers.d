module dangar.handlers.userActionHandlers;

import vibe.d;
import std.digest.sha;
import std.base64;

void createUser(HTTPServerRequest req, HTTPServerResponse res)
{
	string name = req.form["user_name"];
	string password = Base64.encode( sha256Of(req.form["password"]) );

	auto mongoClient = connectMongoDB("127.0.0.1");
	auto collection = mongoClient.getCollection("dangar.users");
	auto user = collection.findOne(["name" : name]);

	if(!user.isNull)
	{
		logInfo("user already exists");
		res.redirect("/error", HTTPStatus.seeOther);
		return;
	}

	collection.insert(Bson(["name" : Bson(name), "password" : Bson(password)]));
	res.redirect("/", HTTPStatus.seeOther);
}

void login(HTTPServerRequest req, HTTPServerResponse res)
{
	string name = req.form["user_name"];
	string password = Base64.encode( sha256Of(req.form["password"]) );

	auto mongoClient = connectMongoDB("127.0.0.1");
	auto collection = mongoClient.getCollection("dangar.users");
	auto user = collection.findOne(["name" : name]);

	if(user.isNull)
	{
		logInfo("user not found");
		res.redirect("/error", HTTPStatus.seeOther);
		return;
	}
	else if(cast(string)user["password"] != password)
	{
		logInfo("incorrect password");
		res.redirect("/error", HTTPStatus.seeOther);
		return;
	}

	logInfo("login succeed");
	auto session = res.startSession();
	session.set("username", name);
	res.redirect("/", HTTPStatus.seeOther);
}

void logout(HTTPServerRequest req, HTTPServerResponse res)
{
	res.terminateSession();
	res.redirect("/", HTTPStatus.seeOther);
}


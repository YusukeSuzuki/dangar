import vibe.d;

void getVersion(HTTPServerRequest req, HTTPServerResponse res)
{
	res.writeBody("0.0.1");
}


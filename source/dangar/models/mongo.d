import vibe.d;

MongoClient client;

void test()
{
	auto coll = client.getCollection("test.coll");

	foreach(doc; coll.find())
	{
		logInfo("found: %s", doc.toJson());
	}
}

shared static this()
{
	client = connectMongoDB("127.0.0.1");
}


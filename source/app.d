import routing;
import dangar.models;

import vibe.d;
import vibe.core.args;
import vibe.db.redis.sessionstore;

T readOption(T)(string name, T defaultValue, string help)
{
	T val = defaultValue;
	vibe.core.args.readOption!(T)(name, &val, help);
	return val;
}

shared static this()
{
	string mode = readOption!(string)("mode", "test", "mode");
	ushort port = readOption!(ushort)("port", 8080, "port");
	string address = readOption!(string)("address", "127.0.0.1", "address");

	printCommandLineHelp();

	logInfo("mode: %s", mode);
	logInfo("port: %d", port);
	logInfo("address: %s", address);

	auto settings = new HTTPServerSettings;
	settings.port = port;
	settings.bindAddresses = [address];
	settings.sessionStore = new RedisSessionStore("127.0.0.1", 0);

	listenHTTP(settings, dangarRouter());
	logInfo("Please open http://%s:%s/ in your browser.",
		address, port);
}


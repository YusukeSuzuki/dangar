import routing;
import dangar.models;

import vibe.d;
import vibe.core.args;

shared static this()
{
	string mode = "test";
	ushort port = 8080;

	{
		readOption!(string)("mode", &mode, "mode");
		readOption!(ushort)("port", &port, "port");
		printCommandLineHelp();
		logInfo("mode: %s", mode);
		logInfo("port: %d", port);
	}

	auto settings = new HTTPServerSettings;
	settings.port = port;
	settings.bindAddresses = ["::1", "127.0.0.1"];

	mongo.test();

	listenHTTP(settings, dangarRouter());
	logInfo("Please open http://127.0.0.1:8080/ in your browser.");
}


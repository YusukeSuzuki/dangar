import routing;

import vibe.d;
import vibe.core.args;

shared static this()
{
	string mode = "develop";

	{
		readOption!(string)("mode", &mode, "mode");
		printCommandLineHelp();
		logInfo("mode: %s", mode);
	}

	auto settings = new HTTPServerSettings;
	settings.port = 8080;
	settings.bindAddresses = ["::1", "127.0.0.1"];

	listenHTTP(settings, dangarRouter());
	logInfo("Please open http://127.0.0.1:8080/ in your browser.");
}


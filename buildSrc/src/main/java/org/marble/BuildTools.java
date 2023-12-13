package org.marble;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.gradle.api.Project;

import java.io.IOException;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Stream;

public final class BuildTools {

	public static void downloadOpenSCAD(Project project) throws IOException {
		final Matcher matcher = Pattern.compile("https://files\\.openscad\\.org/snapshots/OpenSCAD-[\\d.]+-x86-64\\.zip").matcher(getUrl("https://files.openscad.org/snapshots/.snapshot_win64.js"));
		if (matcher.find()) {
			final Path path = project.getProjectDir().toPath().resolve("models/application");
			Files.createDirectories(path);
			FileUtils.copyURLToFile(new URL(matcher.group()), path.resolve("application.zip").toFile());
		}
	}

	public static void build(Project project) throws IOException {
		final Path rootPath = project.getProjectDir().toPath();
		final Path modelsPath = rootPath.resolve("models");
		final Path buildPath = rootPath.resolve("build/models");
		Files.createDirectories(buildPath);

		try (final Stream<Path> stream = Files.list(modelsPath)) {
			stream.forEach(path -> {
				final String fileName = path.getFileName().toString();
				if (fileName.endsWith(".scad")) {
					final ProcessBuilder processBuilder = new ProcessBuilder();
					processBuilder.command(
							modelsPath.resolve("application/openscad.com").toString(),
							"-o",
							buildPath.resolve(fileName.replace(".scad", ".stl")).toString(),
							"-D", "$fn=400",
							path.toString()
					);

					System.out.println(String.join(" ", processBuilder.command()));
					try {
						processBuilder.start().waitFor();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			});
		}
	}

	private static String getUrl(String url) {
		for (int i = 0; i < 5; i++) {
			try {
				return IOUtils.toString(new URL(url), StandardCharsets.UTF_8);
			} catch (Exception e) {
				e.printStackTrace();
			}
			try {
				Thread.sleep(1000);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return "";
	}
}

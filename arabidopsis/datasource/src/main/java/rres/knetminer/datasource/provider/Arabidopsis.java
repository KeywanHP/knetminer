package rres.knetminer.datasource.provider;

import rres.knetminer.datasource.ondexlocal.OndexLocalDataSource;

public class Arabidopsis extends OndexLocalDataSource {

	public Arabidopsis() {
		super("arabidopsis", "config.xml", "SemanticMotifs.txt");
	}

}
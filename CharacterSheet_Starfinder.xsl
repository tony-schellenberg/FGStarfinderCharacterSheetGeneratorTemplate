<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>

	<xsl:template match="character">
		<html>
			<head>
				<link rel="preconnect" href="https://fonts.gstatic.com"/>
				<link href="https://fonts.googleapis.com/css2?family=Exo+2:wght@400;700&amp;display=swap" rel="stylesheet"/>
				<style>
					.stars, .charsheet-root {
					position: absolute;
					display: block;
					top: 0;
					bottom: 0;
					left: 0;
					right: 0;
					width: 100%;
					height: 100%;
					}

					.stars {
					z-index: 0;
					background-color:black;
					background-image:
					radial-gradient(white, rgba(255,255,255,.2) 3px, transparent 10px),
					radial-gradient(white, rgba(255,255,255,.15) 2px, transparent 6px),
					radial-gradient(white, rgba(255,255,255,.1) 2px, transparent 4px),
					radial-gradient(white, rgba(255,255,255,.1) 1px, transparent 2px);
					background-size: 535px 459px, 314px 368px, 250px 250px, 187px 169px;
					background-position: 0 0, 41px 63px, 135px 271px, 73px 101px;
					}

					.charsheet-root {
					z-index: 1;
					background: transparent url() repeat top center;
                    overflow-y: scroll;
					}

					@media print {
                    	.charsheet-root {
							overflow-y: visible;
						}
					}

					body {
					font-family: 'Exo 2', tahoma, sans-serif;
					font-size: 13px;
					}

					.charsheet {
					width: 900px;
					box-sizing: border-box;
					margin: auto;
					}

					.standard-row, .flex-row {
					width: 100%;
					clear: both;
					page-break-inside: avoid;
					}

					.standard-row {
					display: block;
					}

					.flex-row {
					display: flex;
					flex-direction: row;
                    flex-grow: 1;
					}

					.flex-column {
					clear: both;
					display: flex;
					flex-direction: column;
					flex-grow: 1;
					}

					.blocktitle {
					color: white;
					text-align:left;
					padding-left: 1em;
					margin-top: 0.5em;
					text-transform: uppercase;
                    /* Enable these background images for printing even if main background off */
					-webkit-print-color-adjust: exact !important;   /* Chrome, Safari */
					color-adjust: exact !important;                 /*Firefox*/
                    width: 10em;
                    /* purple to red with opacity at 75% */
                    background-image: radial-gradient(ellipse at 0% 100%, #600060 30%, #BF0000 100%);
					clip-path: polygon(0% 0, calc(100% - 0.5em) 0%, 100% 0.5em, 100% 100%, 0.5em 100%, 0% calc(100% - 0.5em));
                    }

					.bordered {
					border: 2px solid #600060;
					background-color: white;
					text-align: left;
                    margin-left: 0.5em;
					clip-path: polygon(0% 0, calc(100% - 1.0em) 0%, 100% 1.0em, 100% 100%, 1.0em 100%, 0% calc(100% - 1.0em));
                    flex-grow: 1;
					}

					.underlined-block {
						display: inline-block;
						text-decoration: underline;
					}

					.div-table {
					display: table;
					border-spacing: 5px; /* cellspacing:poor IE support for  this */
                    width: 100%;
					}

					.div-table-row {
					display: table-row;
					width: auto;
					clear: both;
					}

					.div-table-cell {
					display: table-cell;
					text-align: center;
                    min-height: 1px;
                    vertical-align: top;
					}

					.div-table-cell-left {
					display: table-cell;
					text-align: left;
					min-height: 1px;
					vertical-align: top;
					}

					.centered-3em-box {
						width: 3em;
						text-align: center;
						margin: 0 auto;
					}

					.bordered-smallclip {
					border: 2px solid #600060;
					background-color: white;
					text-align: left;
					clip-path: polygon(0% 0, calc(100% - 1.0em) 0%, 100% 1.0em, 100% 100%, 1.0em 100%, 0% calc(100% - 1.0em));
					}

					.centered-3em-box, .bordered-smallclip {
					clip-path: polygon(0% 0, calc(100% - 0.5em) 0%, 100% 0.5em, 100% 100%, 0.5em 100%, 0% calc(100% - 0.5em));
					}

				</style>
			</head>
			<body>

				<div class="stars">
					<svg width="100%" height="100%" viewBox="0 0 100 100" preserveAspectRatio="none">
						<defs>
							<linearGradient id="grad">
								<stop offset="0" stop-color="red" stop-opacity="0.5"/>
								<stop offset="1" stop-color="blue" stop-opacity="0.5"/>
							</linearGradient>
						</defs>
						<filter id="cloudifyFilter">
							<feTurbulence type="fractalNoise" baseFrequency="0.5" numOctaves="10" result="turbulence"/>
							<feDisplacementMap in2="turbulence" in="SourceGraphic" scale="50" xChannelSelector="R" yChannelSelector="G" result="displaced"/>
							<feGaussianBlur in="displaced" stdDeviation="5" />
						</filter>
						<polygon style="filter: url(#cloudifyFilter)" fill="url(#grad)" points="10,83 25,40 50,50 75,15 90,25 90,30 75,65 50,60 25,70 10,90 " />
					</svg>

					<div name="outer charsheet container for scrolling and printing" class="charsheet-root">
						<div name="inner charsheet container for width" class="charsheet">

							<div name="heading section" class="standard-row">
								<div name="attributes container" style="width: 100%;">
									<!--  Attributes ****************************************** -->
									<div class="blocktitle">ATTRIBUTES</div>
									<div class="bordered">
										<div style="padding-left: 5px;"><b>Name:</b> <div contenteditable="true" class="underlined-block" style="width: 30em;"><xsl:value-of select="name"/></div></div>

										<div name="attributes table" class="div-table">
											<div class="div-table-row">
												<div class="div-table-cell-left"><b>Class/Level:</b>
													<xsl:for-each select="classes/*">
														<div contenteditable="true" class="underlined-block"><xsl:value-of select="name"/> - <xsl:value-of select="level"/></div>
													</xsl:for-each>
												</div>

												<div class="div-table-cell-left"><b>Race:</b> <div contenteditable="true" class="underlined-block"><xsl:value-of select="race"/></div></div>
												<div class="div-table-cell-left"><b>Theme:</b> <div contenteditable="true" class="underlined-block"><xsl:value-of select="theme"/></div></div>
												<div class="div-table-cell-left"><b>Speed:</b> <div contenteditable="true" class="underlined-block" style="width: 10em;"><xsl:value-of select="speed/final"/></div></div>
											</div>
											<div class="div-table-row">
													<div class="div-table-cell-left"><b>Size:</b> <div contenteditable="true" class="underlined-block"><xsl:value-of select="size"/></div></div>
													<div class="div-table-cell-left"><b>Age:</b> <div contenteditable="true" class="underlined-block"><xsl:value-of select="age"/></div></div>
													<div class="div-table-cell-left"><b>Height:</b> <div contenteditable="true" class="underlined-block"><xsl:value-of select="height"/></div></div>
													<div class="div-table-cell-left"><b>Weight:</b> <div contenteditable="true" class="underlined-block"><xsl:value-of select="weight"/></div></div>
											</div>
											<div class="div-table-row">
													<div class="div-table-cell-left"><b>Gender:</b> <div contenteditable="true" class="underlined-block"><xsl:value-of select="gender"/></div></div>
													<div class="div-table-cell-left"><b>Homeworld:</b> <div contenteditable="true" class="underlined-block"><xsl:value-of select="homeworld"/></div></div>
													<div class="div-table-cell-left"><b>Alignment:</b> <div contenteditable="true" class="underlined-block"><xsl:value-of select="alignment"/></div></div>
													<div class="div-table-cell-left"><b>Deity:</b> <div contenteditable="true" class="underlined-block"><xsl:value-of select="deity"/></div></div>
											</div>
										</div>
									</div>
								</div> <!-- attributes container -->
							</div> <!-- heading section -->

							<div name="skills/health/etc section" class="flex-row">
								<div name="experience/abilities/health/resolve container" class="flex-column">
									<!--  Experience ****************************************** -->
									<div class="blocktitle">EXPERIENCE</div>
									<div class="bordered">
										<div name="experience table" class="div-table">
											<div class="div-table-row">
												<div class="div-table-cell"><b>Current</b></div>
												<div class="div-table-cell"><b>Needed</b></div>
											</div>
											<div class="div-table-row">
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box" style="width: 5em;"><xsl:value-of select="exp"/></div></div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box" style="width: 5em;"><xsl:value-of select="expneeded"/></div></div>
											</div>
										</div>
									</div>

									<!--  Abilities ****************************************** -->
									<div class="blocktitle">ABILITY SCORES</div>
									<div class="bordered">
										<div name="abilities table" class="div-table">
											<div class="div-table-row">
												<div class="div-table-cell"><b>Ability</b></div>
												<div  class="div-table-cell"><b>Score</b></div>
												<div  class="div-table-cell"><b>Bonus</b></div>
											</div>
											<div class="div-table-row">
												<div class="div-table-cell">STR</div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="abilities/strength/score"/></div></div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="abilities/strength/bonus"/></div></div>
											</div>
											<div class="div-table-row">
												<div class="div-table-cell">DEX</div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="abilities/dexterity/score"/></div></div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="abilities/dexterity/bonus"/></div></div>
											</div>
											<div class="div-table-row">
												<div class="div-table-cell">CON</div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="abilities/constitution/score"/></div></div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="abilities/constitution/bonus"/></div></div>
											</div>
											<div class="div-table-row">
												<div class="div-table-cell">INT</div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="abilities/intelligence/score"/></div></div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="abilities/intelligence/bonus"/></div></div>
											</div>
											<div class="div-table-row">
												<div class="div-table-cell">WIS</div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="abilities/wisdom/score"/></div></div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="abilities/wisdom/bonus"/></div></div>
											</div>
											<div class="div-table-row">
												<div class="div-table-cell">CHA</div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="abilities/charisma/score"/></div></div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="abilities/charisma/bonus"/></div></div>
											</div>
										</div>
									</div>

									<!--  Initiaitive ****************************************** -->
									<div class="blocktitle">Initiative</div>
									<div class="bordered">
										<div name="initiative table" class="div-table">
											<div class="div-table-row">
												<div class="div-table-cell"><b>Total</b></div>
												<div  class="div-table-cell"><b>Dex Mod</b></div>
												<div  class="div-table-cell"><b>Misc Mod</b></div>
											</div>
											<div class="div-table-row">
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="initiative/total"/></div></div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="abilities/dexterity/bonus"/></div></div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="initiative/misc"/></div></div>
											</div>
										</div>
									</div>

									<!--  Health and Resolve ****************************************** -->
									<div class="blocktitle">HEALTH/RESOLVE</div>
									<div class="bordered">
										<div name="health/resolve table" class="div-table">
											<div class="div-table-row">
												<div class="div-table-cell"></div>
												<div class="div-table-cell"><b>Total</b></div>
												<div class="div-table-cell"><b>Current</b></div>
											</div>
											<div class="div-table-row">
												<div class="div-table-cell">Stamina</div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="sp/total"/></div></div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="sp/current"/></div></div>
											</div>
											<div class="div-table-row">
												<div class="div-table-cell">Health</div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="hp/total"/></div></div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="hp/current"/></div></div>
											</div>
											<div class="div-table-row">
												<div class="div-table-cell">Resolve</div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="rp/total"/></div></div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="rp/current"/></div></div>
											</div>
										</div>
									</div>

									<!--  Coins ****************************************** -->
									<div class="blocktitle">Coins</div>
									<div class="bordered">
										<div name="inventory table" class="div-table">
											<div class="div-table-row">
												<div class="div-table-cell"><b>Type</b></div>
												<div class="div-table-cell"><b>Qty</b></div>
											</div>
											<xsl:for-each select="coins/*">
												<xsl:sort select="name"/>
												<div class="div-table-row">
													<div class="div-table-cell-left" style="text-transform: capitalize;"><xsl:value-of select="name"/></div>
													<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box" style="width: 6em;"><xsl:value-of select="amount"/></div></div>
												</div>
											</xsl:for-each>
										</div>
									</div>
								</div>

								<div name="skills container" class="flex-column">
									<!--  Skills ****************************************** -->
									<div class="blocktitle">SKILLS</div>
									<div class="bordered">
										<div name="skills table" class="div-table">
											<div class="div-table-row">
												<div class="div-table-cell"><b>Name</b></div>
												<div class="div-table-cell"><b>Cls</b></div>
												<div class="div-table-cell"><b>ArChk</b></div>
												<div class="div-table-cell"><b>Stat</b></div>
												<div class="div-table-cell"><b>Ranks</b></div>
												<div class="div-table-cell"><b>Total</b></div>
											</div>
											<xsl:for-each select="skilllist/*">
												<xsl:sort select="label"/>
												<div class="div-table-row">
													<div class="div-table-cell-left" style="text-transform: capitalize"><xsl:value-of select="label"/></div>
													<div class="div-table-cell" style="text-transform: uppercase;">
														<xsl:choose>
															<xsl:when test="state > 0">
																<input type="checkbox" checked="true"/>
															</xsl:when>
															<xsl:otherwise>
																<input type="checkbox"/>
															</xsl:otherwise>
														</xsl:choose>
													</div>
													<div class="div-table-cell" style="text-transform: uppercase;">
														<xsl:choose>
															<xsl:when test="armorcheckmultiplier > 0">
																<input type="checkbox" checked="true"/>
															</xsl:when>
															<xsl:otherwise>
																<input type="checkbox"/>
															</xsl:otherwise>
														</xsl:choose>
													</div>
													<div class="div-table-cell" style="text-transform: uppercase;"><xsl:value-of select="substring(statname,1,3)"/></div>
													<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="ranks"/></div></div>
													<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="total"/></div></div>
												</div>
											</xsl:for-each>
										</div>
									</div>
								</div>

								<div name="armor/throws/bonuses/languages" class="flex-column">
									<!--  Armor ****************************************** -->
									<div class="blocktitle">Armor</div>
									<div class="bordered">
										<div name="armor table" class="div-table">
											<div class="div-table-row">
												<div class="div-table-cell"></div>
												<div class="div-table-cell"><b>Total</b></div>
												<div  class="div-table-cell"><b>Armor</b></div>
												<div  class="div-table-cell"><b>Dex Mod</b></div>
												<div  class="div-table-cell"><b>Misc Mod</b></div>
											</div>
											<div class="div-table-row">
												<div class="div-table-cell">EAC</div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="ac/totals/eac"/></div></div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="ac/sources/eac/armor"/></div></div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="abilities/dexterity/bonus"/></div></div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="ac/sources/eac/misc"/></div></div>
											</div>
											<div class="div-table-row">
												<div class="div-table-cell">KAC</div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="ac/totals/kac"/></div></div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="ac/sources/kac/armor"/></div></div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="abilities/dexterity/bonus"/></div></div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="ac/sources/kac/misc"/></div></div>
											</div>
											<div class="div-table-row">
												<div class="div-table-cell">Vs. Combat Maneuvers</div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="ac/totals/cmd"/></div></div>
												<div class="div-table-cell">KAC + 8</div>
											</div>
										</div>
									</div>

									<!--  Saving Throws ****************************************** -->
									<div class="blocktitle">Saving Throws</div>
									<div class="bordered">
										<div name="saving throws table" class="div-table">
											<div class="div-table-row">
												<div class="div-table-cell"></div>
												<div class="div-table-cell"><b>Total</b></div>
												<div class="div-table-cell"><b>Base</b></div>
												<div class="div-table-cell"><b>Stat Mod</b></div>
												<div class="div-table-cell"><b>Misc Mod</b></div>
											</div>
											<div class="div-table-row">
												<div class="div-table-cell">Fortitude</div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="saves/fortitude/total"/></div></div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="saves/fortitude/base"/></div></div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="abilities/constitution/bonus"/></div></div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="saves/fortitude/misc"/></div></div>
											</div>
											<div class="div-table-row">
												<div class="div-table-cell">Reflex</div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="saves/reflex/total"/></div></div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="saves/reflex/base"/></div></div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="abilities/dexterity/bonus"/></div></div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="saves/reflex/misc"/></div></div>
											</div>
											<div class="div-table-row">
												<div class="div-table-cell">Will</div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="saves/will/total"/></div></div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="saves/will/base"/></div></div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="abilities/wisdom/bonus"/></div></div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="saves/will/misc"/></div></div>
											</div>
										</div>
									</div>

									<!--  Attack Bonuses ****************************************** -->
									<div class="blocktitle">Attack Bonuses</div>
									<div class="bordered">
										<div name="attack bonuses table" class="div-table">
											<div class="div-table-row">
												<div class="div-table-cell"></div>
												<div class="div-table-cell"><b>Total</b></div>
												<div class="div-table-cell"><b>BAB</b></div>
												<div class="div-table-cell"><b>Stat Mod</b></div>
												<div class="div-table-cell"><b>Misc Mod</b></div>
											</div>
											<div class="div-table-row">
												<div class="div-table-cell">Melee</div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="attackbonus/melee/total"/></div></div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="attackbonus/base"/></div></div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="abilities/strength/bonus"/></div></div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="attackbonus/melee/misc"/></div></div>
											</div>
											<div class="div-table-row">
												<div class="div-table-cell">Ranged</div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="attackbonus/ranged/total"/></div></div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="attackbonus/base"/></div></div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="abilities/dexterity/bonus"/></div></div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="attackbonus/ranged/misc"/></div></div>
											</div>
											<div class="div-table-row">
												<div class="div-table-cell">Thrown</div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="attackbonus/thrown/total"/></div></div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="attackbonus/base"/></div></div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="abilities/strength/bonus"/></div></div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="attackbonus/thrown/misc"/></div></div>
											</div>
										</div>
									</div>

									<!--  Senses ****************************************** -->
									<div class="blocktitle">Senses</div>
									<div class="bordered">
										<div name="senses table" class="div-table">
											<div contenteditable="true" class="underlined-block" style="float: left;"><xsl:value-of select="senses"/></div>
										</div>
									</div>

									<!--  Languages ****************************************** -->
									<div class="blocktitle">LANGUAGES</div>
									<div class="bordered">
										<div name="languages table" class="div-table">
											<xsl:for-each select="languagelist/*">
												<div contenteditable="true" class="underlined-block" style="width: 50%; float: left;"><xsl:value-of select="name"/></div>
											</xsl:for-each>
										</div>
									</div>

									<!--  Encumbrance ****************************************** -->
									<div class="blocktitle">Encumbrance</div>
									<div class="bordered">
										<div name="inventory table" class="div-table">
											<div class="div-table-row">
												Current Bulk: <div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="encumbrance/load"/></div>
											</div>
											<div class="div-table-row">
												<div class="div-table-cell">Unencumbered</div>
												<div class="div-table-cell">Encumbered</div>
												<div class="div-table-cell">Overencumbered</div>
											</div>
											<div class="div-table-row">
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="encumbrance/lightload"/></div></div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="encumbrance/mediumload"/></div></div>
												<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="encumbrance/heavyload"/></div></div>
											</div>
										</div>
									</div>

								</div>
							</div>

							<div name="abilities section" class="standard-row">
								<div name="Abilities overview container" style="width: 100%;">
									<!--  Abilities ****************************************** -->
									<div class="blocktitle">ABILITIES</div>
									<div class="bordered">
										<div name="traits table" class="div-table">
											<div class="div-table-row">
												<div class="div-table-cell"><b>Trait</b></div>
												<div class="div-table-cell-left bordered-smallclip" style="text-transform: capitalize;">
													<xsl:for-each select="traitlist/*">
														<xsl:sort select="name"/>
														<div style="width: 20%; float: left;"><xsl:value-of select="name"/></div>
													</xsl:for-each>
												</div>
											</div>
											<div class="div-table-row">
												<div class="div-table-cell"><b>Theme</b></div>
												<div class="div-table-cell-left bordered-smallclip" style="text-transform: capitalize;">
													<xsl:for-each select="themeabilitylist/*">
														<xsl:sort select="name"/>
														<div style="width: 20%; float: left;"><xsl:value-of select="name"/></div>
													</xsl:for-each>
												</div>
											</div>
											<div class="div-table-row">
												<div class="div-table-cell"><b>Class</b></div>
												<div class="div-table-cell-left bordered-smallclip" style="text-transform: capitalize;">
													<xsl:for-each select="specialabilitylist/*">
														<xsl:sort select="name"/>
														<div style="width: 20%; float: left;"><xsl:value-of select="name"/></div>
													</xsl:for-each>
												</div>
											</div>
											<div class="div-table-row">
												<div class="div-table-cell"><b>Proficiencies</b></div>
												<div class="div-table-cell-left bordered-smallclip" style="text-transform: capitalize;">
													<xsl:for-each select="proficiencylist/*">
														<xsl:sort select="name"/>
														<div style="width: 20%; float: left;"><xsl:value-of select="name"/></div>
													</xsl:for-each>
												</div>
											</div>
											<div class="div-table-row">
												<div class="div-table-cell"><b>Feats</b></div>
												<div class="div-table-cell-left bordered-smallclip" style="text-transform: capitalize;">
													<xsl:for-each select="featlist/*">
														<xsl:sort select="name"/>
														<div style="width: 20%; float: left;"><xsl:value-of select="name"/></div>
													</xsl:for-each>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>

							<div name="inventory section" class="standard-row">
								<div name="inventory container" style="width: 100%;">
									<!--  Inventory ****************************************** -->
									<div class="blocktitle">INVENTORY</div>
									<div class="bordered">
										<div name="inventory table" class="div-table">
											<div class="div-table-row">
												<div class="div-table-cell"><b>Name</b></div>
												<div class="div-table-cell"><b>Qty</b></div>
												<div class="div-table-cell"><b>Bulk</b></div>
												<div class="div-table-cell"></div>
												<div class="div-table-cell"></div>
												<div class="div-table-cell"><b>Name</b></div>
												<div class="div-table-cell"><b>Qty</b></div>
												<div class="div-table-cell"><b>Bulk</b></div>
												<div class="div-table-cell"></div>
												<div class="div-table-cell"></div>
												<div class="div-table-cell"><b>Name</b></div>
												<div class="div-table-cell"><b>Qty</b></div>
												<div class="div-table-cell"><b>Bulk</b></div>
												<div class="div-table-cell"></div>
												<div class="div-table-cell"></div>
											</div>
											<xsl:for-each select="inventorylist/*">
												<xsl:sort select="name"/>
                                                <xsl:if test="(position() mod 3) = 1">
												<div class="div-table-row"/>
												</xsl:if>
													<div class="div-table-cell-left" style="text-transform: capitalize;"><xsl:value-of select="name"/></div>
													<div class="div-table-cell" style="text-transform: capitalize;"><xsl:value-of select="count"/></div>
													<div class="div-table-cell" style="text-transform: capitalize;"><xsl:copy-of select="bulk"/></div>
													<div class="div-table-cell" style="text-transform: capitalize;">
														<xsl:if test='carried ="1"' >
															&#9995;
														</xsl:if>
														<xsl:if test='carried ="2"' >
															&#128085;
														</xsl:if>
													</div>
													<div class="div-table-cell" style="width: 2em;"></div>
											</xsl:for-each>
										</div>
										<div style="width: 100%; text-align: right;">* &#9995;: Carried, &#128085;: Equipped</div>
									</div>
								</div>
							</div>

							<div name="melee section" class="standard-row">
								<div name="melee container" style="width: 100%;">
									<!--  Weapons ****************************************** -->
									<div class="blocktitle">MELEE</div>
									<div class="bordered">
										<div name="weapons table" class="div-table">
											<div class="div-table-row">
												<div class="div-table-cell"><b>Weapon</b></div>
												<div class="div-table-cell"><b>Atk Mod</b></div>
												<div class="div-table-cell"><b>Damage</b></div>
												<div class="div-table-cell"><b>Type</b></div>
												<div class="div-table-cell"><b>Special</b></div>
												<div class="div-table-cell"></div>
											</div>
											<xsl:for-each select="weaponlist/*">
												<xsl:sort select="name"/>
												<xsl:if test='type = "0"'>
													<div class="div-table-row">
														<div class="div-table-cell-left" style="text-transform: capitalize;"><xsl:value-of select="name"/></div>
														<div class="div-table-cell-left" style="text-transform: capitalize;">
															<div>Std: <xsl:value-of select="attack0"/></div>
															<div>Full: <xsl:value-of select="attack1"/>/<xsl:value-of select="attack1"/></div>
														</div>
														<xsl:for-each select="damagelist/*">
															<div class="div-table-cell"><xsl:value-of select="dice"/><xsl:text> </xsl:text><xsl:value-of select="type"/></div>
														</xsl:for-each>
														<div class="div-table-cell-left" style="text-transform: capitalize;"><xsl:value-of select="subtype"/></div>
														<div class="div-table-cell-left" style="text-transform: capitalize;"><xsl:value-of select="special"/></div>
														<div class="div-table-cell" style="text-transform: capitalize;">
															<xsl:if test='carried = "1"'>
																&#9995;
															</xsl:if>
															<xsl:if test='carried = "2"'>
																&#128085;
															</xsl:if>
														</div>
													</div>
												</xsl:if>
											</xsl:for-each>
										</div>
										<div style="width: 100%; text-align: right;">* &#9995;: Carried, &#128085;: Equipped</div>
									</div>
								</div>
							</div>
							<div name="ranged section" class="standard-row">
								<div name="ranged container" style="width: 100%;">
									<div class="blocktitle">RANGED</div>
									<div class="bordered">
										<div name="weapons table" class="div-table">
											<div class="div-table-row">
												<div class="div-table-cell"><b>Weapon</b></div>
												<div class="div-table-cell"><b>Atk Mod</b></div>
												<div class="div-table-cell"><b>Damage</b></div>
												<div class="div-table-cell"><b>Range</b></div>
												<div class="div-table-cell"><b>Type</b></div>
												<div class="div-table-cell"><b>Uses/Used</b></div>
												<div class="div-table-cell"><b>Special</b></div>
												<div class="div-table-cell"></div>
											</div>
											<xsl:for-each select="weaponlist/*">
												<xsl:sort select="name"/>
												<xsl:if test='type = "1"'>
													<div class="div-table-row">
														<div class="div-table-cell-left" style="text-transform: capitalize;"><xsl:value-of select="name"/></div>
														<div class="div-table-cell-left" style="text-transform: capitalize;">
															<div>Std: <xsl:value-of select="attack0"/></div>
															<xsl:if test="not(contains(special, 'unwieldy')) and not(contains(special, 'Unwieldy')) and uses > 1">
																<div>Full: <xsl:value-of select="attack1"/>/<xsl:value-of select="attack1"/></div>
															</xsl:if>
														</div>
														<xsl:for-each select="damagelist/*">
															<div class="div-table-cell"><xsl:value-of select="dice"/><xsl:text> </xsl:text><xsl:value-of select="type"/></div>
														</xsl:for-each>
														<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="rangeincrement"/></div></div>
														<div class="div-table-cell-left" style="text-transform: capitalize;"><xsl:value-of select="subtype"/></div>
														<div class="div-table-cell" style="text-transform: capitalize;"><xsl:value-of select="uses"/>/<xsl:value-of select="ammo"/></div>
														<div class="div-table-cell-left" style="text-transform: capitalize;"><xsl:value-of select="special"/></div>
														<div class="div-table-cell" style="text-transform: capitalize;">
															<xsl:if test='carried = "1"'>
																&#9995;
															</xsl:if>
															<xsl:if test='carried = "2"'>
																&#128085;
															</xsl:if>
														</div>
													</div>
												</xsl:if>
											</xsl:for-each>
										</div>
										<div style="width: 100%; text-align: right;">* &#9995;: Carried, &#128085;: Equipped</div>
									</div>
								</div>
							</div>

							<div name="spells section" class="standard-row">
								<div name="spells container" style="width: 100%;">
									<!--  Attributes ****************************************** -->
									<div class="blocktitle">SPELLS</div>
									<div class="bordered">
										<div name="spells table" class="div-table">
											<xsl:for-each select="spellset/*">
												<xsl:sort select="label"/>
												<div><b><xsl:value-of select="label"/></b></div>
												<div name="spells type table" class="div-table bordered-smallclip">
													<div class="div-table-row">
														<div class="div-table-cell"><b>Level</b></div>
														<div class="div-table-cell"><b>Known</b></div>
														<div class="div-table-cell"><b>Remaining</b></div>
														<div class="div-table-cell"><b>Spells</b></div>
													</div>
													<xsl:for-each select="levels/*">
														<xsl:sort select="level"/>
														<xsl:if test="level &lt; 7">
															<div class="div-table-row">
																<!-- This is really complicated to make work well. Only include levels that have at least one spell in them -->
																<xsl:variable name="level" select="level"/>
																<xsl:variable name="knownlevelspells" select="../../*[name()=concat('knownlevel', $level)]"/>
																<xsl:if test="$knownlevelspells &gt; 0">
																	<div class="div-table-cell"><xsl:value-of select="$level"/></div>
																	<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="$knownlevelspells"/></div></div>

																	<div class="div-table-cell"><div contenteditable="true" class="bordered centered-3em-box"><xsl:value-of select="../../*[name()=concat('availablelevel', $level)]"/></div></div>
																	<div class="div-table-cell-left" style="text-transform: capitalize;">
																		<xsl:for-each select="spells/*">
																			<xsl:sort select="name"/>
																			<div style="width: 33%; text-align: left; float: left;"><xsl:value-of select="name"/></div>
																		</xsl:for-each>
																	</div>
																</xsl:if>
															</div>
														</xsl:if>
													</xsl:for-each>
												</div>
											</xsl:for-each>
										</div>
									</div>
								</div>
							</div>

							<div name="appearance section" class="standard-row">
								<div name="appearance container" style="width: 100%;">
									<!--  Appearance ****************************************** -->
									<div class="blocktitle">APPEARANCE</div>
									<div class="bordered">
										<div style="padding: 5px;">
											<xsl:call-template name="replace">
												<xsl:with-param name="string" select="appearance"/>
											</xsl:call-template>
										</div>
									</div>
								</div>
							</div>

							<div name="notes section" class="standard-row">
								<div name="notes container" style="width: 100%;">
									<!--  Appearance ****************************************** -->
									<div class="blocktitle">NOTES</div>
									<div class="bordered">
										<div style="padding: 5px;">
											<xsl:call-template name="replace">
												<xsl:with-param name="string" select="notes"/>
											</xsl:call-template>
										</div>
									</div>
								</div>
							</div>

						</div> <!-- charsheet -->
					</div> <!-- charsheet-root -->
				</div> <!-- Stars -->

			</body>
		</html>
	</xsl:template>

    <!-- From https://www.oxygenxml.com/archives/xsl-list/200203/msg01000.html -->
	<xsl:template name="replace">
		<xsl:param name="string"/>
		<xsl:choose>
			<xsl:when test="contains($string,'\n')">
				<xsl:value-of select="substring-before($string,'\n')"/>
				<br/>
				<xsl:call-template name="replace">
					<xsl:with-param name="string"
									select="substring-after($string,'\n')"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$string"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>

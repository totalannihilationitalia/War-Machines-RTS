return {
	["map"] = [[Eridlon Island]],
	["players"] = {
		[1] = [[Giocatore_1]],
		[2] = [[Asiatic Legion alfa]],
		[3] = [[Giocatore_2]],
		[4] = [[EU Force]],
		[5] = [[Asiatic Legion bravo]],
		[6] = [[Asiatic Legion charlie]],
	},
	["triggers"] = {
		[1] = {
			["name"] = [[Logica: spostamento unità factory 10_spazioporto non conquistato]],
			["logic"] = {
				[1] = {
					["logicType"] = [[UnitsAreInAreaCondition]],
					["args"] = {
						["areas"] = {
							[1] = {
								["category"] = [[rectangle]],
								["x"] = 7148.65932885862,
								["y"] = 2389.51785234884,
								["width"] = 214.415570469785,
								["height"] = 599.037315436205,
							},
						},
						["groups"] = {},
						["players"] = {
							[1] = 5,
						},
						["number"] = 30,
					},
					["name"] = [[Units Are In Area]],
				},
				[2] = {
					["logicType"] = [[GiveOrdersAction]],
					["args"] = {
						["orders"] = {
							[1] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 7247.8143840705,
									[2] = 0,
									[3] = 3041.49653071605,
								},
							},
							[2] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 6509.33539279073,
									[2] = 0,
									[3] = 3059.14941496975,
								},
							},
							[3] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 6503.4510980395,
									[2] = 0,
									[3] = 3453.39716330237,
								},
							},
							[4] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 6497.56680328827,
									[2] = 0,
									[3] = 3897.66141702048,
								},
							},
							[5] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 6897.69884637212,
									[2] = 0,
									[3] = 4324.27278648489,
								},
							},
							[6] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 6709.40141433266,
									[2] = 0,
									[3] = 4759.71059807615,
								},
							},
							[7] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 6185.6991814729,
									[2] = 0,
									[3] = 5745.32996890772,
								},
							},
							[8] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 5670.82339074,
									[2] = 0,
									[3] = 6130.75127511349,
								},
							},
							[9] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 5379.55080055395,
									[2] = 0,
									[3] = 6580.89982358283,
								},
							},
							[10] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 5332.47644254408,
									[2] = 0,
									[3] = 6842.75094001271,
								},
							},
							[11] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 5497.88691014863,
									[2] = 0,
									[3] = 8103.16393357949,
								},
							},
							[12] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 3170.88370782593,
									[2] = 0,
									[3] = 9938.91090430073,
								},
							},
						},
						["groups"] = {
							["Units in factory10 (Asiatic Legion charlie)"] = true,
						},
					},
					["name"] = [[Give Orders]],
				},
			},
			["maxOccurrences"] = -1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[2] = {
			["name"] = [[Logica: Spostamento unità  factory 9_spazioporto non conquistato]],
			["logic"] = {
				[1] = {
					["logicType"] = [[UnitsAreInAreaCondition]],
					["args"] = {
						["areas"] = {
							[1] = {
								["category"] = [[rectangle]],
								["x"] = 6688.59060402663,
								["y"] = 2585.23489932878,
								["width"] = 265.771812080528,
								["height"] = 358.389261744955,
							},
						},
						["groups"] = {},
						["players"] = {
							[1] = 5,
						},
						["number"] = 20,
					},
					["name"] = [[Units Are In Area]],
				},
				[2] = {
					["logicType"] = [[GiveOrdersAction]],
					["args"] = {
						["orders"] = {
							[1] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 6501.4893309823,
									[2] = 0,
									[3] = 3047.52446039604,
								},
							},
							[2] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 6495.60503623107,
									[2] = 0,
									[3] = 3450.59865085552,
								},
							},
							[3] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 6489.72074147983,
									[2] = 0,
									[3] = 3894.86290457363,
								},
							},
							[4] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 6169.02667753762,
									[2] = 0,
									[3] = 4177.30905263282,
								},
							},
							[5] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 6157.25808803516,
									[2] = 0,
									[3] = 4777.50711725861,
								},
							},
							[6] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 6324.9604884453,
									[2] = 0,
									[3] = 5077.60614957151,
								},
							},
							[7] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 6007.20857187871,
									[2] = 0,
									[3] = 5710.16783532908,
								},
							},
							[8] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 5598.250086668,
									[2] = 0,
									[3] = 6245.6386576913,
								},
							},
							[9] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 5380.53118087237,
									[2] = 0,
									[3] = 6586.92775326283,
								},
							},
							[10] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 5315.80393860881,
									[2] = 0,
									[3] = 6892.91108032696,
								},
							},
							[11] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 5405.15695440628,
									[2] = 0,
									[3] = 8093.16010220975,
								},
							},
							[12] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 4863.18398634395,
									[2] = 0,
									[3] = 8893.68898164128,
								},
							},
							[13] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 3167.65387524985,
									[2] = 0,
									[3] = 9972.66268870116,
								},
							},
						},
						["groups"] = {
							["Units in Factory9 (Asiatic Legion charlie)"] = true,
						},
					},
					["name"] = [[Give Orders]],
				},
			},
			["maxOccurrences"] = -1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[3] = {
			["name"] = [[Logica: conteggio torrette distrutte linea difensiva]],
			["logic"] = {
				[1] = {
					["logicType"] = [[UnitDestroyedCondition]],
					["args"] = {
						["groups"] = {
							["asi_leg_difesa"] = true,
						},
					},
					["name"] = [[Unit Destroyed]],
				},
				[2] = {
					["logicType"] = [[ModifyCounterAction]],
					["args"] = {
						["counter"] = [[asi_leg_difesa_alpha]],
						["action"] = [[Increase]],
						["value"] = 1,
					},
					["name"] = [[Modify Counter]],
				},
			},
			["maxOccurrences"] = 11,
			["enabled"] = true,
			["probability"] = 1,
		},
		[4] = {
			["name"] = [[Logica counter Inizio costruzione factory5 (dopo 30 min)]],
			["logic"] = {
				[1] = {
					["logicType"] = [[CountdownEndedCondition]],
					["args"] = {
						["countdown"] = [[counter Inizio costruzione factory5]],
					},
					["name"] = [[Countdown Ended]],
				},
				[2] = {
					["logicType"] = [[GiveFactoryOrdersAction]],
					["args"] = {
						["buildOrders"] = {
							[1] = [[corgarp]],
							[2] = [[corraid]],
							[3] = [[corlevlr]],
							[4] = [[corwolv]],
							[5] = [[cormist]],
							[6] = [[corraid]],
						},
						["builtUnitsGroups"] = {},
						["factoryGroups"] = {
							["factory5"] = true,
						},
						["repeatOrders"] = true,
					},
					["name"] = [[Give Factory Orders]],
				},
				[3] = {
					["logicType"] = [[GiveOrdersAction]],
					["args"] = {
						["orders"] = {
							[1] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 5941.43976610634,
									[2] = 0,
									[3] = 9464.81011367966,
								},
							},
						},
						["groups"] = {
							["factory5"] = true,
						},
					},
					["name"] = [[Give Orders]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[5] = {
			["name"] = [[Logica: spostamento factory 7]],
			["logic"] = {
				[1] = {
					["logicType"] = [[UnitsAreInAreaCondition]],
					["args"] = {
						["areas"] = {
							[1] = {
								["category"] = [[rectangle]],
								["x"] = 5191.56,
								["y"] = 5690.52,
								["width"] = 451.439999999999,
								["height"] = 427.68,
							},
						},
						["groups"] = {},
						["players"] = {
							[1] = 4,
						},
						["number"] = 30,
					},
					["name"] = [[Units Are In Area]],
				},
				[2] = {
					["logicType"] = [[GiveOrdersAction]],
					["args"] = {
						["orders"] = {
							[1] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 5376,
									[2] = 0,
									[3] = 6528,
								},
							},
							[2] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 4848,
									[2] = 0,
									[3] = 8136,
								},
							},
							[3] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 3216,
									[2] = 0,
									[3] = 9960,
								},
							},
						},
						["groups"] = {
							["Units in factory7 (Asiatic Legion bravo)"] = true,
						},
					},
					["name"] = [[Give Orders]],
				},
			},
			["maxOccurrences"] = -1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[6] = {
			["name"] = [[Logica: Spostamento unità factory6 con difese asiatic KO]],
			["logic"] = {
				[1] = {
					["logicType"] = [[UnitsAreInAreaCondition]],
					["args"] = {
						["areas"] = {
							[1] = {
								["category"] = [[rectangle]],
								["x"] = 4043.86677165357,
								["y"] = 6825.73984251973,
								["width"] = 318.241889763783,
								["height"] = 422.49354330709,
							},
						},
						["groups"] = {},
						["players"] = {
							[1] = 4,
						},
						["number"] = 15,
					},
					["name"] = [[Units Are In Area]],
				},
				[2] = {
					["logicType"] = [[GiveOrdersAction]],
					["args"] = {
						["orders"] = {
							[1] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 4114.20849343738,
									[2] = 0,
									[3] = 8167.89641686671,
								},
							},
							[2] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 5874.37758237378,
									[2] = 0,
									[3] = 8162.92418780192,
								},
							},
							[3] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 6988.1568928872,
									[2] = 0,
									[3] = 8197.72979125546,
								},
							},
							[4] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 9061.5764129055,
									[2] = 0,
									[3] = 8212.64647844984,
								},
							},
							[5] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 9464.32696715366,
									[2] = 0,
									[3] = 8073.42406463566,
								},
							},
							[6] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 8932.29845722091,
									[2] = 0,
									[3] = 8451.31347355986,
								},
							},
							[7] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 8628.99248426859,
									[2] = 0,
									[3] = 9744.0930304058,
								},
							},
							[8] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 8047.24168368792,
									[2] = 0,
									[3] = 9679.4540525635,
								},
							},
							[9] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 9225.65997204364,
									[2] = 0,
									[3] = 9565.09278407329,
								},
							},
							[10] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 9663.21612974534,
									[2] = 0,
									[3] = 8729.75830118822,
								},
							},
							[11] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 10235.0224721964,
									[2] = 0,
									[3] = 8073.42406463566,
								},
							},
							[12] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 10926.1623122025,
									[2] = 0,
									[3] = 7844.70152765523,
								},
							},
							[13] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 11055.4402678871,
									[2] = 0,
									[3] = 6855.2279437616,
								},
							},
						},
						["groups"] = {
							["Units in factory6 (Asiatic Legion beta)"] = true,
							["Units in factory6 (Asiatic Legion bravo)"] = true,
						},
					},
					["name"] = [[Give Orders]],
				},
			},
			["maxOccurrences"] = -1,
			["enabled"] = false,
			["probability"] = 1,
		},
		[7] = {
			["name"] = [[Logica: Spostamento unità factory6 con difese asiatic legion alfa attive]],
			["logic"] = {
				[1] = {
					["logicType"] = [[UnitsAreInAreaCondition]],
					["args"] = {
						["areas"] = {
							[1] = {
								["category"] = [[rectangle]],
								["x"] = 4070.17322834658,
								["y"] = 6788.52755905533,
								["width"] = 317.456692913396,
								["height"] = 380.527559055131,
							},
						},
						["groups"] = {},
						["players"] = {
							[1] = 4,
						},
						["number"] = 15,
					},
					["name"] = [[Units Are In Area]],
				},
				[2] = {
					["logicType"] = [[GiveOrdersAction]],
					["args"] = {
						["orders"] = {
							[1] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 4103.51934456076,
									[2] = 0,
									[3] = 8177.85826288133,
								},
							},
							[2] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 4135.83883348191,
									[2] = 0,
									[3] = 9360.75155739537,
								},
							},
							[3] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 3760.93276199659,
									[2] = 0,
									[3] = 9431.8544330219,
								},
							},
							[4] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 2907.69825447827,
									[2] = 0,
									[3] = 9981.28574468142,
								},
							},
						},
						["groups"] = {
							["Units in factory6 (Asiatic Legion beta)"] = true,
							["Units in factory6 (Asiatic Legion bravo)"] = true,
						},
					},
					["name"] = [[Give Orders]],
				},
			},
			["maxOccurrences"] = -1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[8] = {
			["name"] = [[Logica: Spostamento unità factory5]],
			["logic"] = {
				[1] = {
					["logicType"] = [[UnitsAreInAreaCondition]],
					["args"] = {
						["areas"] = {
							[1] = {
								["category"] = [[rectangle]],
								["x"] = 5738.04,
								["y"] = 9242.64,
								["width"] = 451.439999999999,
								["height"] = 439.559999999999,
							},
						},
						["groups"] = {},
						["players"] = {
							[1] = 4,
						},
						["number"] = 15,
					},
					["name"] = [[Units Are In Area]],
				},
				[2] = {
					["logicType"] = [[GiveOrdersAction]],
					["args"] = {
						["orders"] = {
							[1] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 5827.75224957109,
									[2] = 0,
									[3] = 8204.7160813697,
								},
							},
							[2] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 9053.5355776456,
									[2] = 0,
									[3] = 8180.65049269611,
								},
							},
							[3] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 8666.42912781508,
									[2] = 0,
									[3] = 9747.37211602945,
								},
							},
							[4] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 9138.29366606385,
									[2] = 0,
									[3] = 9540.5273869341,
								},
							},
							[5] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 9752.36395556567,
									[2] = 0,
									[3] = 8771.32355061076,
								},
							},
							[6] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 10256.5479827356,
									[2] = 0,
									[3] = 8027.97530542435,
								},
							},
							[7] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 10877.0821700216,
									[2] = 0,
									[3] = 7905.16124752398,
								},
							},
							[8] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 11019.2879212747,
									[2] = 0,
									[3] = 6870.93760204723,
								},
							},
						},
						["groups"] = {
							["Units in factory5 (Asiatic Legion beta)"] = true,
							["Units in factory5 (Asiatic Legion bravo)"] = true,
						},
					},
					["name"] = [[Give Orders]],
				},
			},
			["maxOccurrences"] = -1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[9] = {
			["name"] = [[Logica obiettivo 1: Spostamento unità factory4]],
			["logic"] = {
				[1] = {
					["logicType"] = [[UnitsAreInAreaCondition]],
					["args"] = {
						["areas"] = {
							[1] = {
								["category"] = [[rectangle]],
								["x"] = 10940.1393230771,
								["y"] = 7365.34966153856,
								["width"] = 198.275446153848,
								["height"] = 358.645292307697,
							},
						},
						["groups"] = {},
						["players"] = {
							[1] = 1,
						},
						["number"] = 15,
					},
					["name"] = [[Units Are In Area]],
				},
				[2] = {
					["logicType"] = [[GiveOrdersAction]],
					["args"] = {
						["orders"] = {
							[1] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 10964.9689540233,
									[2] = 0,
									[3] = 7937.47008095825,
								},
							},
							[2] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 10318.5791756003,
									[2] = 0,
									[3] = 8046.85912038367,
								},
							},
							[3] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 9726.88391689002,
									[2] = 0,
									[3] = 8847.3879998152,
								},
							},
							[4] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 9179.93871976289,
									[2] = 0,
									[3] = 9568.36121421005,
								},
							},
							[5] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 8677.74358421889,
									[2] = 0,
									[3] = 9737.41700241298,
								},
							},
							[6] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 8682.71581328368,
									[2] = 0,
									[3] = 9573.33344327484,
								},
							},
							[7] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 8951.21618278246,
									[2] = 0,
									[3] = 8345.1928642712,
								},
							},
							[8] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 9527.99475429834,
									[2] = 0,
									[3] = 8091.6091819668,
								},
							},
							[9] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 8026.38157673113,
									[2] = 0,
									[3] = 8191.05376326264,
								},
							},
							[10] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 7524.18644118713,
									[2] = 0,
									[3] = 8454.58190369662,
								},
							},
							[11] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 7305.40836233628,
									[2] = 0,
									[3] = 9021.41601708292,
								},
							},
							[12] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 7290.4916751419,
									[2] = 0,
									[3] = 9841.83381277361,
								},
							},
							[13] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 7166.1859485221,
									[2] = 0,
									[3] = 10358.945635512,
								},
							},
							[14] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 7151.26926132773,
									[2] = 0,
									[3] = 11378.2525937944,
								},
							},
						},
						["groups"] = {
							["Units in factory4 (Asiatic Legion)"] = true,
							["Units in factory4 (Asiatic Legion alfa)"] = true,
						},
					},
					["name"] = [[Give Orders]],
				},
			},
			["maxOccurrences"] = -1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[10] = {
			["name"] = [[Logica obiettivo 1: Spostamento unità factory3]],
			["logic"] = {
				[1] = {
					["logicType"] = [[UnitsAreInAreaCondition]],
					["args"] = {
						["areas"] = {
							[1] = {
								["category"] = [[rectangle]],
								["x"] = 9428.90547692318,
								["y"] = 7955.32430769239,
								["width"] = 295.387569230772,
								["height"] = 278.604184615387,
							},
						},
						["groups"] = {},
						["players"] = {
							[1] = 1,
						},
						["number"] = 5,
					},
					["name"] = [[Units Are In Area]],
				},
				[2] = {
					["logicType"] = [[GiveOrdersAction]],
					["args"] = {
						["orders"] = {
							[1] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 9169.73002625949,
									[2] = 0,
									[3] = 8211.51822551011,
								},
							},
							[2] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 8110.5569710375,
									[2] = 0,
									[3] = 8199.74963600764,
								},
							},
							[3] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 7554.49111704596,
									[2] = 0,
									[3] = 8435.12142605697,
								},
							},
							[4] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 7327.94576912348,
									[2] = 0,
									[3] = 9011.78231167782,
								},
							},
							[5] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 7310.29288486978,
									[2] = 0,
									[3] = 9820.87283997239,
								},
							},
							[6] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 7157.30122133772,
									[2] = 0,
									[3] = 10344.5750728322,
								},
							},
							[7] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 7154.3590739621,
									[2] = 0,
									[3] = 11444.9381913128,
								},
							},
						},
						["groups"] = {
							["Units in factory3 (Asiatic Legion)"] = true,
							["Units in factory3 (Asiatic Legion alfa)"] = true,
						},
					},
					["name"] = [[Give Orders]],
				},
			},
			["maxOccurrences"] = -1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[11] = {
			["name"] = [[Logica obiettivo 1: Spostamento unità factory2]],
			["logic"] = {
				[1] = {
					["logicType"] = [[UnitsAreInAreaCondition]],
					["args"] = {
						["areas"] = {
							[1] = {
								["category"] = [[rectangle]],
								["x"] = 9552.57230769244,
								["y"] = 8525.32467692319,
								["width"] = 348.876553846159,
								["height"] = 578.692061538469,
							},
						},
						["groups"] = {},
						["players"] = {
							[1] = 1,
						},
						["number"] = 15,
					},
					["name"] = [[Units Are In Area]],
				},
				[2] = {
					["logicType"] = [[GiveOrdersAction]],
					["args"] = {
						["orders"] = {
							[1] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 9418.08567829089,
									[2] = 0,
									[3] = 9107.62340753377,
								},
							},
							[2] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 9156.23456186101,
									[2] = 0,
									[3] = 9646.03637727161,
								},
							},
							[3] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 8673.72239225988,
									[2] = 0,
									[3] = 9763.72227229628,
								},
							},
							[4] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 8673.72239225988,
									[2] = 0,
									[3] = 9584.25128238366,
								},
							},
							[5] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 8950.28424556785,
									[2] = 0,
									[3] = 8372.08656362962,
								},
							},
							[6] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 9544.5980154424,
									[2] = 0,
									[3] = 8063.16108918987,
								},
							},
							[7] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 8600.16870786947,
									[2] = 0,
									[3] = 8180.84698421454,
								},
							},
							[8] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 7655.73940029653,
									[2] = 0,
									[3] = 8292.64858448797,
								},
							},
							[9] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 7493.92129463762,
									[2] = 0,
									[3] = 8692.78062757183,
								},
							},
							[10] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 7308.56600997377,
									[2] = 0,
									[3] = 9051.72260739706,
								},
							},
							[11] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 7296.79742047131,
									[2] = 0,
									[3] = 9863.75528306724,
								},
							},
							[12] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 7158.51649381733,
									[2] = 0,
									[3] = 10446.3004634393,
								},
							},
							[13] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 7158.51649381733,
									[2] = 0,
									[3] = 11278.9281707388,
								},
							},
						},
						["groups"] = {
							["Units in factory2 (Asiatic Legion)"] = true,
							["Units in factory2 (Asiatic Legion alfa)"] = true,
						},
					},
					["name"] = [[Give Orders]],
				},
			},
			["maxOccurrences"] = -1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[12] = {
			["name"] = [[Logica obiettivo 1: Spostamento unità factory1]],
			["logic"] = {
				[1] = {
					["logicType"] = [[UnitsAreInAreaCondition]],
					["args"] = {
						["areas"] = {
							[1] = {
								["category"] = [[rectangle]],
								["x"] = 8102.16,
								["y"] = 9563.4,
								["width"] = 451.440000000001,
								["height"] = 368.280000000001,
							},
						},
						["groups"] = {},
						["players"] = {
							[1] = 1,
						},
						["number"] = 10,
					},
					["name"] = [[Units Are In Area]],
				},
				[2] = {
					["logicType"] = [[GiveOrdersAction]],
					["args"] = {
						["orders"] = {
							[1] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 8676.96609664895,
									[2] = 0,
									[3] = 9743.15926070412,
								},
							},
							[2] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 8950.43869521251,
									[2] = 0,
									[3] = 8385.74072601588,
								},
							},
							[3] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 9571.96732831152,
									[2] = 0,
									[3] = 8022.76800428606,
								},
							},
							[4] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 8647.13272226019,
									[2] = 0,
									[3] = 8191.82379248899,
								},
							},
							[5] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 7836.65938469909,
									[2] = 0,
									[3] = 8231.60162500733,
								},
							},
							[6] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 7513.4644954876,
									[2] = 0,
									[3] = 8455.35193292297,
								},
							},
							[7] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 7289.71418757196,
									[2] = 0,
									[3] = 9156.43623105865,
								},
							},
							[8] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 7299.65864570154,
									[2] = 0,
									[3] = 9877.4094454535,
								},
							},
							[9] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 7155.46400282257,
									[2] = 0,
									[3] = 10309.9933740904,
								},
							},
							[10] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 7165.40846095215,
									[2] = 0,
									[3] = 11369.0781648911,
								},
							},
						},
						["groups"] = {
							["Units in Region 1 (Asiatic Legion)"] = true,
							["Units in factory1 (Asiatic Legion)"] = true,
							["Units in factory1 (Asiatic Legion alfa)"] = true,
						},
					},
					["name"] = [[Give Orders]],
				},
			},
			["maxOccurrences"] = -1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[13] = {
			["name"] = [[Initialization]],
			["logic"] = {
				[1] = {
					["logicType"] = [[GamePreloadCondition]],
					["args"] = {},
					["name"] = [[Game Preload]],
				},
				[2] = {
					["logicType"] = [[CreateUnitsAction]],
					["args"] = {
						["units"] = {
							[1] = {
								["unitDefName"] = [[cordoom]],
								["x"] = 6096,
								["y"] = 8272,
								["player"] = 1,
								["groups"] = {
									["asi_leg_difesa"] = true,
								},
								["heading"] = 90.7044722424387,
								["isGhost"] = false,
							},
							[2] = {
								["unitDefName"] = [[cordoom]],
								["x"] = 6096,
								["y"] = 8144,
								["player"] = 1,
								["groups"] = {
									["asi_leg_difesa"] = true,
								},
								["heading"] = 90.3500511227307,
								["isGhost"] = false,
							},
							[3] = {
								["unitDefName"] = [[corpun]],
								["x"] = 6168,
								["y"] = 8152,
								["player"] = 1,
								["groups"] = {
									["asi_leg_difesa"] = true,
								},
								["heading"] = 89.8977648095733,
								["isGhost"] = false,
							},
							[4] = {
								["unitDefName"] = [[corpun]],
								["x"] = 6168,
								["y"] = 8264,
								["player"] = 1,
								["groups"] = {
									["asi_leg_difesa"] = true,
								},
								["heading"] = 90.7621674867457,
								["isGhost"] = false,
							},
							[5] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 6032,
								["y"] = 8072,
								["player"] = 1,
								["groups"] = {
									["nfa_nano001"] = true,
									["asi_leg_difesa"] = true,
								},
								["heading"] = 89.6240459896287,
								["isGhost"] = false,
							},
							[6] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 6040,
								["y"] = 8336,
								["player"] = 1,
								["groups"] = {
									["nfa_nano001"] = true,
									["asi_leg_difesa"] = true,
								},
								["heading"] = 91.31480305582,
								["isGhost"] = false,
							},
							[7] = {
								["unitDefName"] = [[corrad]],
								["x"] = 6024,
								["y"] = 8264,
								["player"] = 1,
								["groups"] = {
									["asi_leg_difesa"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[8] = {
								["unitDefName"] = [[corhlt]],
								["x"] = 6096,
								["y"] = 8064,
								["player"] = 1,
								["groups"] = {
									["asi_leg_difesa"] = true,
								},
								["heading"] = 89.1264095118591,
								["isGhost"] = false,
							},
							[9] = {
								["unitDefName"] = [[corhlt]],
								["x"] = 6096,
								["y"] = 8016,
								["player"] = 1,
								["groups"] = {
									["asi_leg_difesa"] = true,
								},
								["heading"] = 87.3425973700692,
								["isGhost"] = false,
							},
							[10] = {
								["unitDefName"] = [[corhlt]],
								["x"] = 6096,
								["y"] = 8352,
								["player"] = 1,
								["groups"] = {
									["asi_leg_difesa"] = true,
								},
								["heading"] = 93.1795195426461,
								["isGhost"] = false,
							},
							[11] = {
								["unitDefName"] = [[corhlt]],
								["x"] = 6096,
								["y"] = 8400,
								["player"] = 1,
								["groups"] = {
									["asi_leg_difesa"] = true,
								},
								["heading"] = 89.4553622641745,
								["isGhost"] = false,
							},
							[12] = {
								["unitDefName"] = [[corfus]],
								["x"] = 10992,
								["y"] = 6696,
								["player"] = 1,
								["groups"] = {
									["asi_leg_power"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[13] = {
								["unitDefName"] = [[corfus]],
								["x"] = 11088,
								["y"] = 6696,
								["player"] = 1,
								["groups"] = {
									["asi_leg_power"] = true,
								},
								["heading"] = 89.9869119062427,
								["isGhost"] = false,
							},
							[14] = {
								["unitDefName"] = [[corflak]],
								["x"] = 11032,
								["y"] = 6584,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[15] = {
								["unitDefName"] = [[corflak]],
								["x"] = 11096,
								["y"] = 6856,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 88.2763856337951,
								["isGhost"] = false,
							},
							[16] = {
								["unitDefName"] = [[corflak]],
								["x"] = 11192,
								["y"] = 7104,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 87.469009814097,
								["isGhost"] = false,
							},
							[17] = {
								["unitDefName"] = [[corflak]],
								["x"] = 11240,
								["y"] = 7344,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 89.0998057737318,
								["isGhost"] = false,
							},
							[18] = {
								["unitDefName"] = [[corflak]],
								["x"] = 11128,
								["y"] = 7560,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 91.31456874954,
								["isGhost"] = false,
							},
							[19] = {
								["unitDefName"] = [[corflak]],
								["x"] = 11072,
								["y"] = 7800,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 91.6767432648884,
								["isGhost"] = false,
							},
							[20] = {
								["unitDefName"] = [[corflak]],
								["x"] = 10928,
								["y"] = 8104,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 181.973042103609,
								["isGhost"] = false,
							},
							[21] = {
								["unitDefName"] = [[corexp]],
								["x"] = 10928,
								["y"] = 7616,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[22] = {
								["unitDefName"] = [[corexp]],
								["x"] = 10944,
								["y"] = 7512,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 91.4358554471048,
								["isGhost"] = false,
							},
							[23] = {
								["unitDefName"] = [[corexp]],
								["x"] = 10080,
								["y"] = 8264,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[24] = {
								["unitDefName"] = [[corexp]],
								["x"] = 10056,
								["y"] = 8360,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 177.628216059454,
								["isGhost"] = false,
							},
							[25] = {
								["unitDefName"] = [[corexp]],
								["x"] = 9368,
								["y"] = 10632,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[26] = {
								["unitDefName"] = [[corexp]],
								["x"] = 9688,
								["y"] = 10496,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 269.117335082946,
								["isGhost"] = false,
							},
							[27] = {
								["unitDefName"] = [[cormex]],
								["x"] = 9712,
								["y"] = 10656,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[28] = {
								["unitDefName"] = [[cormex]],
								["x"] = 9152,
								["y"] = 8616,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[29] = {
								["unitDefName"] = [[cormex]],
								["x"] = 9240,
								["y"] = 8504,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[30] = {
								["unitDefName"] = [[corvp]],
								["x"] = 7920,
								["y"] = 9736,
								["player"] = 1,
								["groups"] = {
									["factory1"] = true,
								},
								["heading"] = 90.1904263138243,
								["isGhost"] = false,
							},
							[31] = {
								["unitDefName"] = [[corllt]],
								["x"] = 8000,
								["y"] = 9824,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 90.4113177821853,
								["isGhost"] = false,
							},
							[32] = {
								["unitDefName"] = [[corllt]],
								["x"] = 8000,
								["y"] = 9640,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 90.7141944965728,
								["isGhost"] = false,
							},
							[33] = {
								["unitDefName"] = [[corlab]],
								["x"] = 9560,
								["y"] = 7848,
								["player"] = 1,
								["groups"] = {
									["factory3"] = true,
								},
								["heading"] = 180.818724534831,
								["isGhost"] = false,
							},
							[34] = {
								["unitDefName"] = [[corllt]],
								["x"] = 9648,
								["y"] = 7936,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 268.720358903573,
								["isGhost"] = false,
							},
							[35] = {
								["unitDefName"] = [[corllt]],
								["x"] = 8672,
								["y"] = 8280,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 268.851140997408,
								["isGhost"] = false,
							},
							[36] = {
								["unitDefName"] = [[corllt]],
								["x"] = 8672,
								["y"] = 8128,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 266.75272130918,
								["isGhost"] = false,
							},
							[37] = {
								["unitDefName"] = [[corlab]],
								["x"] = 9992,
								["y"] = 8712,
								["player"] = 1,
								["groups"] = {
									["factory2"] = true,
								},
								["heading"] = 270.462497873387,
								["isGhost"] = false,
							},
							[38] = {
								["unitDefName"] = [[corllt]],
								["x"] = 9920,
								["y"] = 8792,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 267.787761595115,
								["isGhost"] = false,
							},
							[39] = {
								["unitDefName"] = [[corllt]],
								["x"] = 9920,
								["y"] = 8616,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 270.089422302076,
								["isGhost"] = false,
							},
							[40] = {
								["unitDefName"] = [[corrad]],
								["x"] = 10072,
								["y"] = 8632,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 269.546733964457,
								["isGhost"] = false,
							},
							[41] = {
								["unitDefName"] = [[corjamt]],
								["x"] = 10072,
								["y"] = 8784,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[42] = {
								["unitDefName"] = [[corjamt]],
								["x"] = 7824,
								["y"] = 9640,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[43] = {
								["unitDefName"] = [[corrad]],
								["x"] = 7824,
								["y"] = 9824,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[44] = {
								["unitDefName"] = [[cormstor]],
								["x"] = 10896,
								["y"] = 6984,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[45] = {
								["unitDefName"] = [[cormstor]],
								["x"] = 10896,
								["y"] = 7064,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 90.5826604500964,
								["isGhost"] = false,
							},
							[46] = {
								["unitDefName"] = [[corestor]],
								["x"] = 10984,
								["y"] = 6976,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[47] = {
								["unitDefName"] = [[corestor]],
								["x"] = 10976,
								["y"] = 7080,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 273.100531039354,
								["isGhost"] = false,
							},
							[48] = {
								["unitDefName"] = [[corhlt]],
								["x"] = 10888,
								["y"] = 7832,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 268.768170305403,
								["isGhost"] = false,
							},
							[49] = {
								["unitDefName"] = [[corhlt]],
								["x"] = 10888,
								["y"] = 8104,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 272.419996824307,
								["isGhost"] = false,
							},
							[50] = {
								["unitDefName"] = [[corrad]],
								["x"] = 10920,
								["y"] = 7792,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[51] = {
								["unitDefName"] = [[corlab]],
								["x"] = 11040,
								["y"] = 7304,
								["player"] = 1,
								["groups"] = {
									["factory4"] = true,
								},
								["heading"] = 180.350046971346,
								["isGhost"] = false,
							},
							[52] = {
								["unitDefName"] = [[corhlt]],
								["x"] = 10952,
								["y"] = 7376,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 181.396678033282,
								["isGhost"] = false,
							},
							[53] = {
								["unitDefName"] = [[corhlt]],
								["x"] = 11112,
								["y"] = 7384,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 178.275140868396,
								["isGhost"] = false,
							},
							[54] = {
								["unitDefName"] = [[corhlt]],
								["x"] = 10936,
								["y"] = 6784,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 179.746561049359,
								["isGhost"] = false,
							},
							[55] = {
								["unitDefName"] = [[corhlt]],
								["x"] = 11048,
								["y"] = 6776,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 177.930414683183,
								["isGhost"] = false,
							},
							[56] = {
								["unitDefName"] = [[corrad]],
								["x"] = 10960,
								["y"] = 7232,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[57] = {
								["unitDefName"] = [[corrad]],
								["x"] = 11072,
								["y"] = 6624,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[58] = {
								["unitDefName"] = [[corvp]],
								["x"] = 5968,
								["y"] = 9816,
								["player"] = 4,
								["groups"] = {
									["factory5"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[59] = {
								["unitDefName"] = [[corjamt]],
								["x"] = 5880,
								["y"] = 9896,
								["player"] = 4,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[60] = {
								["unitDefName"] = [[corrad]],
								["x"] = 6048,
								["y"] = 9904,
								["player"] = 4,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[61] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 5912,
								["y"] = 9960,
								["player"] = 4,
								["groups"] = {
									["nfa_nano001"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[62] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 6016,
								["y"] = 9960,
								["player"] = 4,
								["groups"] = {
									["nfa_nano001"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[63] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 5896,
								["y"] = 7768,
								["player"] = 4,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[64] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 5984,
								["y"] = 7792,
								["player"] = 4,
								["groups"] = {},
								["heading"] = 88.1430475195948,
								["isGhost"] = false,
							},
							[65] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 4704,
								["y"] = 6104,
								["player"] = 4,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[66] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 4752,
								["y"] = 6160,
								["player"] = 4,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[67] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 4688,
								["y"] = 6200,
								["player"] = 4,
								["groups"] = {},
								["heading"] = 269.895453141411,
								["isGhost"] = false,
							},
							[68] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 4200,
								["y"] = 6136,
								["player"] = 4,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[69] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 4200,
								["y"] = 6232,
								["player"] = 4,
								["groups"] = {},
								["heading"] = 91.9930100330483,
								["isGhost"] = false,
							},
							[70] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 4240,
								["y"] = 6456,
								["player"] = 4,
								["groups"] = {},
								["heading"] = 98.5840387150003,
								["isGhost"] = false,
							},
							[71] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 4152,
								["y"] = 6608,
								["player"] = 4,
								["groups"] = {},
								["heading"] = 268.841379142901,
								["isGhost"] = false,
							},
							[72] = {
								["unitDefName"] = [[cordoom]],
								["x"] = 4112,
								["y"] = 6912,
								["player"] = 4,
								["groups"] = {},
								["heading"] = 180.096038080194,
								["isGhost"] = false,
							},
							[73] = {
								["unitDefName"] = [[cordoom]],
								["x"] = 4280,
								["y"] = 6944,
								["player"] = 4,
								["groups"] = {},
								["heading"] = 178.85096980004,
								["isGhost"] = false,
							},
							[74] = {
								["unitDefName"] = [[coradvsol]],
								["x"] = 4320,
								["y"] = 6088,
								["player"] = 4,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[75] = {
								["unitDefName"] = [[coradvsol]],
								["x"] = 4320,
								["y"] = 6144,
								["player"] = 4,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[76] = {
								["unitDefName"] = [[coradvsol]],
								["x"] = 4320,
								["y"] = 6208,
								["player"] = 4,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[77] = {
								["unitDefName"] = [[cormstor]],
								["x"] = 4512,
								["y"] = 6088,
								["player"] = 4,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[78] = {
								["unitDefName"] = [[cormstor]],
								["x"] = 4584,
								["y"] = 6080,
								["player"] = 4,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[79] = {
								["unitDefName"] = [[corestor]],
								["x"] = 4512,
								["y"] = 6152,
								["player"] = 4,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[80] = {
								["unitDefName"] = [[corestor]],
								["x"] = 4568,
								["y"] = 6160,
								["player"] = 4,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[81] = {
								["unitDefName"] = [[corvp]],
								["x"] = 4248,
								["y"] = 6720,
								["player"] = 4,
								["groups"] = {
									["factory6"] = true,
								},
								["heading"] = 180.185294156313,
								["isGhost"] = false,
							},
							[82] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 4312,
								["y"] = 6624,
								["player"] = 4,
								["groups"] = {
									["nfa_nano002"] = true,
								},
								["heading"] = 179.598227109198,
								["isGhost"] = false,
							},
							[83] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 4240,
								["y"] = 6624,
								["player"] = 4,
								["groups"] = {
									["nfa_nano002"] = true,
								},
								["heading"] = 178.923415266924,
								["isGhost"] = false,
							},
							[84] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 4136,
								["y"] = 6696,
								["player"] = 4,
								["groups"] = {
									["nfa_nano002"] = true,
								},
								["heading"] = 89.2146401111099,
								["isGhost"] = false,
							},
							[85] = {
								["unitDefName"] = [[cormex]],
								["x"] = 4136,
								["y"] = 6152,
								["player"] = 4,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[86] = {
								["unitDefName"] = [[corgator]],
								["x"] = 4976,
								["y"] = 7656,
								["player"] = 4,
								["groups"] = {
									["bravo001"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[87] = {
								["unitDefName"] = [[corgator]],
								["x"] = 5024,
								["y"] = 7656,
								["player"] = 4,
								["groups"] = {
									["bravo001"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[88] = {
								["unitDefName"] = [[corgator]],
								["x"] = 5072,
								["y"] = 7656,
								["player"] = 4,
								["groups"] = {
									["bravo001"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[89] = {
								["unitDefName"] = [[corgator]],
								["x"] = 5120,
								["y"] = 7656,
								["player"] = 4,
								["groups"] = {
									["bravo001"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[90] = {
								["unitDefName"] = [[corgator]],
								["x"] = 5168,
								["y"] = 7656,
								["player"] = 4,
								["groups"] = {
									["bravo001"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[91] = {
								["unitDefName"] = [[corgator]],
								["x"] = 5216,
								["y"] = 7656,
								["player"] = 4,
								["groups"] = {
									["bravo001"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[92] = {
								["unitDefName"] = [[corgator]],
								["x"] = 5216,
								["y"] = 7720,
								["player"] = 4,
								["groups"] = {
									["bravo001"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[93] = {
								["unitDefName"] = [[corgator]],
								["x"] = 5168,
								["y"] = 7720,
								["player"] = 4,
								["groups"] = {
									["bravo001"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[94] = {
								["unitDefName"] = [[corgator]],
								["x"] = 5120,
								["y"] = 7720,
								["player"] = 4,
								["groups"] = {
									["bravo001"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[95] = {
								["unitDefName"] = [[corgator]],
								["x"] = 5072,
								["y"] = 7720,
								["player"] = 4,
								["groups"] = {
									["bravo001"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[96] = {
								["unitDefName"] = [[corgator]],
								["x"] = 5024,
								["y"] = 7720,
								["player"] = 4,
								["groups"] = {
									["bravo001"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[97] = {
								["unitDefName"] = [[corgator]],
								["x"] = 4976,
								["y"] = 7720,
								["player"] = 4,
								["groups"] = {
									["bravo001"] = true,
								},
								["heading"] = 0.351252436026584,
								["isGhost"] = false,
							},
							[98] = {
								["unitDefName"] = [[corllt]],
								["x"] = 5880,
								["y"] = 9736,
								["player"] = 4,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[99] = {
								["unitDefName"] = [[corllt]],
								["x"] = 6048,
								["y"] = 9728,
								["player"] = 4,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[100] = {
								["unitDefName"] = [[corvp]],
								["x"] = 5688,
								["y"] = 5576,
								["player"] = 4,
								["groups"] = {
									["factory7"] = true,
								},
								["heading"] = 180.500080655046,
								["isGhost"] = false,
							},
							[101] = {
								["unitDefName"] = [[corhlt]],
								["x"] = 5608,
								["y"] = 5680,
								["player"] = 4,
								["groups"] = {},
								["heading"] = 179.643748523691,
								["isGhost"] = false,
							},
							[102] = {
								["unitDefName"] = [[corhlt]],
								["x"] = 5776,
								["y"] = 5680,
								["player"] = 4,
								["groups"] = {},
								["heading"] = 177.917072275847,
								["isGhost"] = false,
							},
							[103] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 5592,
								["y"] = 5488,
								["player"] = 4,
								["groups"] = {
									["nano_factory7"] = true,
								},
								["heading"] = 180.99421182348,
								["isGhost"] = false,
							},
							[104] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 5640,
								["y"] = 5488,
								["player"] = 4,
								["groups"] = {
									["nano_factory7"] = true,
								},
								["heading"] = 181.20465646646,
								["isGhost"] = false,
							},
							[105] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 5688,
								["y"] = 5480,
								["player"] = 4,
								["groups"] = {
									["nano_factory7"] = true,
								},
								["heading"] = 177.576251703016,
								["isGhost"] = false,
							},
							[106] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 5736,
								["y"] = 5488,
								["player"] = 4,
								["groups"] = {
									["nano_factory7"] = true,
								},
								["heading"] = 180.858389988918,
								["isGhost"] = false,
							},
							[107] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 5784,
								["y"] = 5480,
								["player"] = 4,
								["groups"] = {
									["nano_factory7"] = true,
								},
								["heading"] = 179.396774263977,
								["isGhost"] = false,
							},
						},
						["useOrbitalDrop"] = false,
						["ceg"] = [[]],
					},
					["name"] = [[Crea unità Asiatic Legion alfa e bravo]],
				},
				[3] = {
					["logicType"] = [[FadeOutAction]],
					["args"] = {
						["instant"] = true,
					},
					["name"] = [[Fade Out]],
				},
				[4] = {
					["logicType"] = [[EnterCutsceneAction]],
					["args"] = {
						["instant"] = true,
					},
					["name"] = [[Enter Cutscene]],
				},
				[5] = {
					["logicType"] = [[CustomAction2]],
					["args"] = {
						["codeStr"] = [[eu_fence=Spring.CreateUnit("EUF_fence_wall",2973,0,9267,2,3)
eu_fence=Spring.CreateUnit("EUF_fence_wall",3020,0,9238,1,3)
eu_fence=Spring.CreateUnit("EUF_fence_wall",3095,0,9238,1,3)
eu_fence=Spring.CreateUnit("EUF_fence_wall",3170,0,9238,1,3)
eu_fence=Spring.CreateUnit("EUF_fence_wall",3245,0,9238,1,3)
eu_fence=Spring.CreateUnit("EUF_fence_wall",3320,0,9238,1,3)
eu_fence=Spring.CreateUnit("EUF_fence_wall",3395,0,9238,1,3)
eu_fence=Spring.CreateUnit("EUF_fence_wall",3470,0,9238,1,3)
eu_fence=Spring.CreateUnit("EUF_fence_wall",3500,0,9285,0,3)
eu_fence=Spring.CreateUnit("EUF_fence_wall",3500,0,9360,0,3)
eu_fence=Spring.CreateUnit("EUF_fence_wall",3500,0,9435,0,3)
eu_gate=Spring.CreateUnit("EUF_fence_gate",3500,0,9552,0,3)
eu_fence=Spring.CreateUnit("EUF_fence_wall",3500,0,9670,0,3)
eu_fence=Spring.CreateUnit("EUF_fence_wall",3500,0,9745,0,3)
eu_fence=Spring.CreateUnit("EUF_fence_wall",3500,0,9820,0,3)
eu_fence=Spring.CreateUnit("EUF_fence_wall",3500,0,9895,0,3)
eu_fence=Spring.CreateUnit("EUF_fence_wall",3500,0,9970,0,3)
eu_fence=Spring.CreateUnit("EUF_fence_wall",3500,0,10045,0,3)
eu_fence=Spring.CreateUnit("EUF_fence_wall",3500,0,10120,0,3)
eu_fence=Spring.CreateUnit("EUF_fence_wall",3500,0,10195,0,3)]],
						["synced"] = true,
					},
					["name"] = [[Custom Action create EU Force fence]],
				},
				[6] = {
					["logicType"] = [[CustomAction2]],
					["args"] = {
						["codeStr"] = [[eu_pilonax_a=Spring.CreateUnit("EUF_pilonax",3027,0,9301,2,3)
eu_pilonax_b=Spring.CreateUnit("EUF_pilonax",3582,0,9301,1,3)
eu_pilonax_c=Spring.CreateUnit("EUF_pilonax",3343,0,9656,1,3)
eu_pilonax_d=Spring.CreateUnit("EUF_pilonax",3582,0,9640,1,3)
eu_factory=Spring.CreateUnit("armblab",3237,0,10021,2,Spring.GetGaiaTeamID())

 Spring.GiveOrderToUnit(eu_pilonax_a,CMD.MOVE_STATE,{0},{"alt"})
 Spring.GiveOrderToUnit(eu_pilonax_b,CMD.MOVE_STATE,{0},{"alt"})
 Spring.GiveOrderToUnit(eu_pilonax_c,CMD.MOVE_STATE,{0},{"alt"})
 Spring.GiveOrderToUnit(eu_pilonax_d,CMD.MOVE_STATE,{0},{"alt"})

Spring.SetUnitNeutral (eu_factory,  true)
Spring.SetUnitAlwaysVisible(eu_factory,  true)
]],
						["synced"] = true,
					},
					["name"] = [[Custom Action create EU Force pilonax]],
				},
				[7] = {
					["logicType"] = [[CustomAction2]],
					["args"] = {
						["codeStr"] = [[spazioporto=Spring.CreateUnit("armspazioporto",9550,0,7350,0,Spring.GetGaiaTeamID())
Spring.SetUnitNeutral (spazioporto,  true)
Spring.SetUnitAlwaysVisible(spazioporto,  true)
Spring.SetUnitNoMinimap(spazioporto,  true)]],
						["synced"] = true,
					},
					["name"] = [[Custom Action crea spazioporto (neutrale)]],
				},
				[8] = {
					["logicType"] = [[CustomAction2]],
					["args"] = {
						["codeStr"] = [[EUF_battery1a=Spring.CreateUnit("screamer",1344,0,9861,0,Spring.GetGaiaTeamID())
Spring.SetUnitNeutral (EUF_battery1a,  true)
Spring.SetUnitAlwaysVisible(EUF_battery1a,  true)
Spring.SetUnitNoMinimap(EUF_battery1a,  true)

EUF_battery1b=Spring.CreateUnit("screamer",1120,0,10050,0,Spring.GetGaiaTeamID())
Spring.SetUnitNeutral (EUF_battery1b,  true)
Spring.SetUnitAlwaysVisible(EUF_battery1b,  true)
Spring.SetUnitNoMinimap(EUF_battery1b,  true)

centralina_EUF_battery1=Spring.CreateUnit("controllo_spazioporto",1344,0,10020,0,Spring.GetGaiaTeamID())
Spring.SetUnitNeutral (centralina_EUF_battery1,  true)
Spring.SetUnitAlwaysVisible(centralina_EUF_battery1,  true)
Spring.SetUnitNoMinimap(centralina_EUF_battery1,  true)]],
						["synced"] = true,
					},
					["name"] = [[Custom Action crea EU batterie missilistiche]],
				},
				[9] = {
					["logicType"] = [[CreateUnitsAction]],
					["args"] = {
						["units"] = {
							[1] = {
								["unitDefName"] = [[controllo_spazioporto]],
								["x"] = 9336,
								["y"] = 7416,
								["player"] = 3,
								["groups"] = {
									["Controllo_spazioporto"] = true,
								},
								["heading"] = 2.49933218828411,
								["isGhost"] = false,
							},
						},
						["useOrbitalDrop"] = false,
						["ceg"] = [[]],
					},
					["name"] = [[Create Units centralina spazioporto]],
				},
				[10] = {
					["logicType"] = [[MakeUnitsNeutralAction]],
					["args"] = {
						["group"] = [[Controllo_spazioporto]],
						["value"] = true,
					},
					["name"] = [[Make Units Neutral]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[14] = {
			["name"] = [[Game Start]],
			["logic"] = {
				[1] = {
					["logicType"] = [[SaveCameraStateAction]],
					["args"] = {},
					["name"] = [[Save Camera State]],
				},
				[2] = {
					["logicType"] = [[SetCameraPosDirAction]],
					["args"] = {
						["px"] = 6930,
						["py"] = 5000,
						["pz"] = 11422,
						["rx"] = 90,
						["ry"] = 180,
						["time"] = 90,
					},
					["name"] = [[Set Camera Position/Direction]],
				},
				[3] = {
					["logicType"] = [[GameStartedCondition]],
					["args"] = {},
					["name"] = [[Game Starts]],
				},
				[4] = {
					["logicType"] = [[CreateUnitsAction]],
					["args"] = {
						["units"] = {
							[1] = {
								["unitDefName"] = [[armhvytransp]],
								["x"] = 6912,
								["y"] = 11416,
								["player"] = 0,
								["groups"] = {
									["transp_player1"] = true,
								},
								["heading"] = 358.716967667152,
								["isGhost"] = false,
							},
						},
						["useOrbitalDrop"] = false,
						["ceg"] = [[]],
					},
					["name"] = [[Create Units trasporto player 1]],
				},
				[5] = {
					["logicType"] = [[StartCountdownAction]],
					["args"] = {
						["countdown"] = [[001_Parlato: collegamento]],
						["display"] = false,
						["frames"] = 60,
					},
					["name"] = [[Start Countdown 001_Parlato: collegamento]],
				},
				[6] = {
					["logicType"] = [[StartCountdownAction]],
					["args"] = {
						["countdown"] = [[eliminazione trasportatore del player 1]],
						["display"] = false,
						["frames"] = 2040,
					},
					["name"] = [[Start Countdown eliminazione trasportatore del player 1]],
				},
				[7] = {
					["logicType"] = [[StartCountdownAction]],
					["args"] = {
						["countdown"] = [[counter Inizio costruzione factory5]],
						["display"] = false,
						["frames"] = 54000,
					},
					["name"] = [[Start Countdown  Inizio costruzione factory5]],
				},
				[8] = {
					["logicType"] = [[GiveOrdersAction]],
					["args"] = {
						["orders"] = {
							[1] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 6024,
									[2] = 0,
									[3] = 9144,
								},
							},
						},
						["groups"] = {
							["nfa_nano001"] = true,
							["nfa_nano002"] = true,
						},
					},
					["name"] = [[Give Orders cornano patrol]],
				},
				[9] = {
					["logicType"] = [[GiveOrdersAction]],
					["args"] = {
						["orders"] = {
							[1] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 4192.19997292823,
									[2] = 0,
									[3] = 7122.35268315707,
								},
							},
						},
						["groups"] = {
							["factory6"] = true,
						},
					},
					["name"] = [[Give Orders factory 6]],
				},
				[10] = {
					["logicType"] = [[GiveFactoryOrdersAction]],
					["args"] = {
						["buildOrders"] = {
							[1] = [[cormist]],
							[2] = [[corwolv]],
							[3] = [[corlevlr]],
							[4] = [[corraid]],
							[5] = [[corgarp]],
							[6] = [[corgator]],
						},
						["builtUnitsGroups"] = {},
						["factoryGroups"] = {
							["factory6"] = true,
						},
						["repeatOrders"] = true,
					},
					["name"] = [[Give Factory Orders factory 6]],
				},
				[11] = {
					["logicType"] = [[GiveOrdersAction]],
					["args"] = {
						["orders"] = {
							[1] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 4320.42291841776,
									[2] = 0,
									[3] = 8823.2961009887,
								},
							},
							[2] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 3627.34886546313,
									[2] = 0,
									[3] = 9490.73748704988,
								},
							},
						},
						["groups"] = {
							["bravo001"] = true,
						},
					},
					["name"] = [[Give Orders bravo001]],
				},
				[12] = {
					["logicType"] = [[CustomAction2]],
					["args"] = {
						["codeStr"] = [[Spring.SetTeamResource(3,"ms",0)
Spring.SetTeamResource(3,"es",0)
Spring.SetTeamResource(3,"m",0)
Spring.SetTeamResource(3,"e",0)

Spring.SetTeamResource(0,"ms",2000)
Spring.SetTeamResource(0,"es",2000)
Spring.SetTeamResource(0,"m",2000)
Spring.SetTeamResource(0,"e",2000)
Spring.SetTeamResource(2,"ms",2000)
Spring.SetTeamResource(2,"es",2000)
Spring.SetTeamResource(2,"m",2000)
Spring.SetTeamResource(2,"e",2000)]],
						["synced"] = true,
					},
					["name"] = [[Custom Action imposto i magazzini degli alleati e dei giocatori]],
				},
				[13] = {
					["logicType"] = [[LockUnitsAction]],
					["args"] = {
						["units"] = {
							[1] = [[armaap]],
							[2] = [[armalab]],
							[3] = [[armap]],
							[4] = [[coravp]],
							[5] = [[nfaap]],
							[6] = [[corasy]],
							[7] = [[armavp]],
							[8] = [[coraap]],
							[9] = [[corap]],
							[10] = [[coralab]],
							[11] = [[armasy]],
							[12] = [[corsy]],
							[13] = [[armsy]],
						},
					},
					["name"] = [[Lock Units]],
				},
				[14] = {
					["logicType"] = [[StartCountdownAction]],
					["args"] = {
						["countdown"] = [[inizio attacco a EUF]],
						["display"] = false,
						["frames"] = 900,
					},
					["name"] = [[Start Countdown inizio attacco a EUF]],
				},
				[15] = {
					["logicType"] = [[GiveOrdersAction]],
					["args"] = {
						["orders"] = {
							[1] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 5687.78749705737,
									[2] = 0,
									[3] = 5751.67806085765,
								},
							},
							[2] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 5445.80022770192,
									[2] = 0,
									[3] = 5889.21039380067,
								},
							},
						},
						["groups"] = {
							["factory7"] = true,
						},
					},
					["name"] = [[Give Orders factory7]],
				},
				[16] = {
					["logicType"] = [[GiveOrdersAction]],
					["args"] = {
						["orders"] = {
							[1] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 5400,
									[2] = 0,
									[3] = 5736,
								},
							},
						},
						["groups"] = {
							["nano_factory7"] = true,
						},
					},
					["name"] = [[Give Orders nano factory 7]],
				},
				[17] = {
					["logicType"] = [[AllowUnitTransfersAction]],
					["args"] = {},
					["name"] = [[Allow Unit Transfers]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[15] = {
			["name"] = [[001_Parlato: collegamento]],
			["logic"] = {
				[1] = {
					["logicType"] = [[CountdownEndedCondition]],
					["args"] = {
						["countdown"] = [[001_Parlato: collegamento]],
					},
					["name"] = [[Countdown Ended]],
				},
				[2] = {
					["logicType"] = [[FadeInAction]],
					["args"] = {
						["instant"] = false,
					},
					["name"] = [[Fade In]],
				},
				[3] = {
					["logicType"] = [[ConvoMessageAction]],
					["args"] = {
						["message"] = [[Collegamento in corso...]],
						["fontSize"] = 14,
						["time"] = 180,
						["image"] = [[Avatar_stazione.png]],
						["imageWidth"] = 145,
						["imageHeight"] = 180,
					},
					["name"] = [[Convo Message]],
				},
				[4] = {
					["logicType"] = [[SetCameraPosDirAction]],
					["args"] = {
						["px"] = 6100,
						["py"] = 20000,
						["pz"] = 6100,
						["rx"] = -90,
						["ry"] = 180,
						["time"] = 0,
					},
					["name"] = [[Set Camera Position/Direction]],
				},
				[5] = {
					["logicType"] = [[StartCountdownAction]],
					["args"] = {
						["countdown"] = [[002_Parlato: inserimento unità]],
						["display"] = false,
						["frames"] = 180,
					},
					["name"] = [[Start Countdown 002_Parlato: inserimento unità]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[16] = {
			["name"] = [[002_Parlato: inserimento unità]],
			["logic"] = {
				[1] = {
					["logicType"] = [[CountdownEndedCondition]],
					["args"] = {
						["countdown"] = [[002_Parlato: inserimento unità]],
					},
					["name"] = [[Countdown Ended]],
				},
				[2] = {
					["logicType"] = [[SetCameraPosDirAction]],
					["args"] = {
						["px"] = 6930,
						["py"] = 5000,
						["pz"] = 11422,
						["rx"] = -90,
						["ry"] = 180,
						["time"] = 3,
					},
					["name"] = [[Set Camera Position/Direction]],
				},
				[3] = {
					["logicType"] = [[ConvoMessageAction]],
					["args"] = {
						["message"] = [[...Si prepari comandante! stiamo inserendo le sue unità al porto di Eridlon...]],
						["fontSize"] = 14,
						["time"] = 180,
						["image"] = [[Avatar_stazione.png]],
						["imageWidth"] = 145,
						["imageHeight"] = 180,
					},
					["name"] = [[Convo Message]],
				},
				[4] = {
					["logicType"] = [[StartCountdownAction]],
					["args"] = {
						["countdown"] = [[003_Parlato: inserimento unità]],
						["display"] = false,
						["frames"] = 180,
					},
					["name"] = [[Start Countdown 003_Parlato: inserimento unità]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[17] = {
			["name"] = [[003_Parlato: inserimento unità]],
			["logic"] = {
				[1] = {
					["logicType"] = [[CountdownEndedCondition]],
					["args"] = {
						["countdown"] = [[003_Parlato: inserimento unità]],
					},
					["name"] = [[Countdown Ended]],
				},
				[2] = {
					["logicType"] = [[SetCameraPointTargetAction]],
					["args"] = {
						["x"] = 9290.16,
						["y"] = 5357.88,
					},
					["name"] = [[Point Camera at Map Location]],
				},
				[3] = {
					["logicType"] = [[ConvoMessageAction]],
					["args"] = {
						["message"] = [[...entri nella città "Shion", utilizzi le risorse della zona per costruire un avamposto...]],
						["fontSize"] = 14,
						["time"] = 180,
						["image"] = [[Avatar_stazione.png]],
						["imageWidth"] = 145,
						["imageHeight"] = 180,
					},
					["name"] = [[Convo Message]],
				},
				[4] = {
					["logicType"] = [[StartCountdownAction]],
					["args"] = {
						["countdown"] = [[004_Parlato: inserimento unità]],
						["display"] = false,
						["frames"] = 180,
					},
					["name"] = [[Start Countdown 004_Parlato: inserimento unità]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[18] = {
			["name"] = [[004_Parlato: inserimento unità]],
			["logic"] = {
				[1] = {
					["logicType"] = [[CountdownEndedCondition]],
					["args"] = {
						["countdown"] = [[004_Parlato: inserimento unità]],
					},
					["name"] = [[Countdown Ended]],
				},
				[2] = {
					["logicType"] = [[SetCameraPointTargetAction]],
					["args"] = {
						["x"] = 3148.2,
						["y"] = 6949.8,
					},
					["name"] = [[Point Camera at Map Location]],
				},
				[3] = {
					["logicType"] = [[ConvoMessageAction]],
					["args"] = {
						["message"] = [[...dovete aiutare l' EU Force a difendere la base e quello che rimane della sua cittadina...]],
						["fontSize"] = 14,
						["time"] = 180,
						["image"] = [[Avatar_stazione.png]],
						["imageWidth"] = 145,
						["imageHeight"] = 180,
					},
					["name"] = [[Convo Message]],
				},
				[4] = {
					["logicType"] = [[StartCountdownAction]],
					["args"] = {
						["countdown"] = [[005_Parlato: inserimento unità]],
						["display"] = false,
						["frames"] = 180,
					},
					["name"] = [[Start Countdown 005_Parlato: inserimento unità]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[19] = {
			["name"] = [[005_Parlato: inserimento unità]],
			["logic"] = {
				[1] = {
					["logicType"] = [[CountdownEndedCondition]],
					["args"] = {
						["countdown"] = [[005_Parlato: inserimento unità]],
					},
					["name"] = [[Countdown Ended]],
				},
				[2] = {
					["logicType"] = [[ConvoMessageAction]],
					["args"] = {
						["message"] = [[...ulteriori istruzioni vi saranno date in missione, buona fortuna!]],
						["fontSize"] = 14,
						["time"] = 150,
						["image"] = [[Avatar_stazione.png]],
						["imageWidth"] = 145,
						["imageHeight"] = 180,
					},
					["name"] = [[Convo Message]],
				},
				[3] = {
					["logicType"] = [[SetCameraPointTargetAction]],
					["args"] = {
						["x"] = 7282.44,
						["y"] = 8268.48,
					},
					["name"] = [[Point Camera at Map Location]],
				},
				[4] = {
					["logicType"] = [[StartCountdownAction]],
					["args"] = {
						["countdown"] = [[006_Parlato: inserimento unità]],
						["display"] = false,
						["frames"] = 180,
					},
					["name"] = [[Start Countdown 006_Parlato: inserimento unità]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[20] = {
			["name"] = [[006_Parlato: inserimento unità]],
			["logic"] = {
				[1] = {
					["logicType"] = [[CountdownEndedCondition]],
					["args"] = {
						["countdown"] = [[006_Parlato: inserimento unità]],
					},
					["name"] = [[Countdown Ended]],
				},
				[2] = {
					["logicType"] = [[FadeInAction]],
					["args"] = {
						["instant"] = false,
					},
					["name"] = [[Fade In]],
				},
				[3] = {
					["logicType"] = [[LeaveCutsceneAction]],
					["args"] = {
						["instant"] = false,
					},
					["name"] = [[Leave Cutscene]],
				},
				[4] = {
					["logicType"] = [[RestoreCameraStateAction]],
					["args"] = {},
					["name"] = [[Restore Camera State]],
				},
				[5] = {
					["logicType"] = [[StartCountdownAction]],
					["args"] = {
						["countdown"] = [[Rilascio_unità1_player1]],
						["display"] = false,
						["frames"] = 30,
					},
					["name"] = [[Start Countdown]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[21] = {
			["name"] = [[Rilascio_unità1_player1 e  avvio prouzione asian legion alfa factory 1 e 3]],
			["logic"] = {
				[1] = {
					["logicType"] = [[CreateUnitsAction]],
					["args"] = {
						["units"] = {
							[1] = {
								["unitDefName"] = [[armbull]],
								["x"] = 6976,
								["y"] = 11384,
								["player"] = 0,
								["groups"] = {},
								["heading"] = 89.5585677555098,
								["isGhost"] = false,
							},
							[2] = {
								["unitDefName"] = [[armbull]],
								["x"] = 6968,
								["y"] = 11448,
								["player"] = 0,
								["groups"] = {},
								["heading"] = 88.1809466938395,
								["isGhost"] = false,
							},
							[3] = {
								["unitDefName"] = [[armseer]],
								["x"] = 6848,
								["y"] = 11456,
								["player"] = 0,
								["groups"] = {},
								["heading"] = 91.5574167428088,
								["isGhost"] = false,
							},
							[4] = {
								["unitDefName"] = [[icuck]],
								["x"] = 6848,
								["y"] = 11424,
								["player"] = 0,
								["groups"] = {},
								["heading"] = 89.9424010411304,
								["isGhost"] = false,
							},
							[5] = {
								["unitDefName"] = [[icuck]],
								["x"] = 6848,
								["y"] = 11384,
								["player"] = 0,
								["groups"] = {},
								["heading"] = 89.5078584344549,
								["isGhost"] = false,
							},
							[6] = {
								["unitDefName"] = [[armrock]],
								["x"] = 6888,
								["y"] = 11384,
								["player"] = 0,
								["groups"] = {},
								["heading"] = 88.8675305355227,
								["isGhost"] = false,
							},
							[7] = {
								["unitDefName"] = [[armrock]],
								["x"] = 6920,
								["y"] = 11384,
								["player"] = 0,
								["groups"] = {},
								["heading"] = 89.7392965010926,
								["isGhost"] = false,
							},
							[8] = {
								["unitDefName"] = [[armrock]],
								["x"] = 6920,
								["y"] = 11424,
								["player"] = 0,
								["groups"] = {},
								["heading"] = 86.2565242197607,
								["isGhost"] = false,
							},
							[9] = {
								["unitDefName"] = [[armrock]],
								["x"] = 6888,
								["y"] = 11424,
								["player"] = 0,
								["groups"] = {},
								["heading"] = 92.1061034187651,
								["isGhost"] = false,
							},
							[10] = {
								["unitDefName"] = [[armrock]],
								["x"] = 6888,
								["y"] = 11456,
								["player"] = 0,
								["groups"] = {},
								["heading"] = 88.9764077017964,
								["isGhost"] = false,
							},
							[11] = {
								["unitDefName"] = [[armrock]],
								["x"] = 6920,
								["y"] = 11456,
								["player"] = 0,
								["groups"] = {},
								["heading"] = 90.3026141389904,
								["isGhost"] = false,
							},
						},
						["useOrbitalDrop"] = false,
						["ceg"] = [[]],
					},
					["name"] = [[Create Units unità iniziali player 1]],
				},
				[2] = {
					["logicType"] = [[GiveOrdersAction]],
					["args"] = {
						["orders"] = {
							[1] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 7151.09913706928,
									[2] = 0,
									[3] = 11410.5488031509,
								},
							},
						},
						["groups"] = {},
					},
					["name"] = [[Give Orders]],
				},
				[3] = {
					["logicType"] = [[CountdownEndedCondition]],
					["args"] = {
						["countdown"] = [[Rilascio_unità1_player1]],
					},
					["name"] = [[Countdown Ended Rilascio_unità1_player1]],
				},
				[4] = {
					["logicType"] = [[GiveFactoryOrdersAction]],
					["args"] = {
						["buildOrders"] = {
							[1] = [[corgator]],
							[2] = [[corgarp]],
							[3] = [[corgator]],
							[4] = [[corgator]],
							[5] = [[cormist]],
							[6] = [[cormist]],
							[7] = [[corwolv]],
							[8] = [[corraid]],
							[9] = [[corraid]],
							[10] = [[corfav]],
						},
						["builtUnitsGroups"] = {},
						["factoryGroups"] = {
							["factory1"] = true,
						},
						["repeatOrders"] = true,
					},
					["name"] = [[Give Factory  1 Orders]],
				},
				[5] = {
					["logicType"] = [[GiveFactoryOrdersAction]],
					["args"] = {
						["buildOrders"] = {
							[1] = [[corak]],
							[2] = [[corstorm]],
							[3] = [[corstorm]],
							[4] = [[corak]],
							[5] = [[corthud]],
							[6] = [[corthud]],
						},
						["builtUnitsGroups"] = {},
						["factoryGroups"] = {
							["factory3"] = true,
						},
						["repeatOrders"] = true,
					},
					["name"] = [[Give Factory 3 Orders]],
				},
				[6] = {
					["logicType"] = [[GiveOrdersAction]],
					["args"] = {
						["orders"] = {
							[1] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 8317.58694982385,
									[2] = 0,
									[3] = 9733.24650780193,
								},
							},
						},
						["groups"] = {
							["factory1"] = true,
						},
					},
					["name"] = [[Give Orders factory 1]],
				},
				[7] = {
					["logicType"] = [[GiveOrdersAction]],
					["args"] = {
						["orders"] = {
							[1] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 9764.12780203236,
									[2] = 0,
									[3] = 8674.60447678787,
								},
							},
						},
						["groups"] = {
							["factory2"] = true,
						},
					},
					["name"] = [[Give Orders factory 2]],
				},
				[8] = {
					["logicType"] = [[GiveOrdersAction]],
					["args"] = {
						["orders"] = {
							[1] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 9531.51378504476,
									[2] = 0,
									[3] = 8072.63490391947,
								},
							},
						},
						["groups"] = {
							["factory3"] = true,
						},
					},
					["name"] = [[Give Orders factory 3]],
				},
				[9] = {
					["logicType"] = [[GiveOrdersAction]],
					["args"] = {
						["orders"] = {
							[1] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 11034.1129271555,
									[2] = 0,
									[3] = 7460.31304133757,
								},
							},
						},
						["groups"] = {
							["factory4"] = true,
						},
					},
					["name"] = [[Give Orders factory 4]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[22] = {
			["name"] = [[eliminazione trasportatore del player 1]],
			["logic"] = {
				[1] = {
					["logicType"] = [[CountdownEndedCondition]],
					["args"] = {
						["countdown"] = [[eliminazione trasportatore del player 1]],
					},
					["name"] = [[Countdown Ended]],
				},
				[2] = {
					["logicType"] = [[DestroyUnitsAction]],
					["args"] = {
						["group"] = [[transp_player1]],
						["explode"] = false,
					},
					["name"] = [[Destroy Units]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[23] = {
			["name"] = [[007_parlato: shion conquistata da legione asiatica]],
			["logic"] = {
				[1] = {
					["logicType"] = [[UnitsAreInAreaCondition]],
					["args"] = {
						["areas"] = {
							[1] = {
								["category"] = [[rectangle]],
								["x"] = 6747.84,
								["y"] = 9135.72,
								["width"] = 997.920000000001,
								["height"] = 914.76,
							},
						},
						["groups"] = {},
						["players"] = {
							[1] = 0,
							[2] = 2,
						},
						["number"] = 1,
					},
					["name"] = [[Units Are In Area]],
				},
				[2] = {
					["logicType"] = [[EnterCutsceneAction]],
					["args"] = {
						["instant"] = false,
					},
					["name"] = [[Enter Cutscene]],
				},
				[3] = {
					["logicType"] = [[SaveCameraStateAction]],
					["args"] = {},
					["name"] = [[Save Camera State]],
				},
				[4] = {
					["logicType"] = [[SetCameraPosDirAction]],
					["args"] = {
						["px"] = 9600,
						["py"] = 7000,
						["pz"] = 8600,
						["rx"] = -90,
						["ry"] = 180,
						["time"] = 1,
					},
					["name"] = [[Set Camera Position/Direction]],
				},
				[5] = {
					["logicType"] = [[CreateUnitsAction]],
					["args"] = {
						["units"] = {
							[1] = {
								["unitDefName"] = [[cormex]],
								["x"] = 7928,
								["y"] = 10176,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[2] = {
								["unitDefName"] = [[corexp]],
								["x"] = 8072,
								["y"] = 10224,
								["player"] = 1,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
						},
						["useOrbitalDrop"] = false,
						["ceg"] = [[]],
					},
					["name"] = [[Create Units]],
				},
				[6] = {
					["logicType"] = [[ConvoMessageAction]],
					["args"] = {
						["message"] = [[Comandante, Shion è stata conquistata dalla Legione Asiatica, la nostra intelligence non aveva previsto questo....]],
						["fontSize"] = 14,
						["time"] = 180,
						["image"] = [[Avatar_stazione.png]],
						["imageWidth"] = 145,
						["imageHeight"] = 180,
					},
					["name"] = [[Convo Message]],
				},
				[7] = {
					["logicType"] = [[StartCountdownAction]],
					["args"] = {
						["countdown"] = [[008_parlato: shion conquistata da legione asiatica]],
						["display"] = false,
						["frames"] = 180,
					},
					["name"] = [[Start Countdown]],
				},
				[8] = {
					["logicType"] = [[CustomAction2]],
					["args"] = {
						["codeStr"] = [[eu_fence=Spring.CreateUnit("armarad",3427,0,9317,0,3)]],
						["synced"] = true,
					},
					["name"] = [[Create Units EUF]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[24] = {
			["name"] = [[008_parlato: shion conquistata da legione asiatica]],
			["logic"] = {
				[1] = {
					["logicType"] = [[MakeUnitsAlwaysVisibleAction]],
					["args"] = {
						["group"] = [[asi_leg_difesa]],
						["value"] = true,
					},
					["name"] = [[Make Units Always Visible]],
				},
				[2] = {
					["logicType"] = [[CountdownEndedCondition]],
					["args"] = {
						["countdown"] = [[008_parlato: shion conquistata da legione asiatica]],
					},
					["name"] = [[Countdown Ended]],
				},
				[3] = {
					["logicType"] = [[SetCameraPosDirAction]],
					["args"] = {
						["px"] = 6000,
						["py"] = 2500,
						["pz"] = 8200,
						["rx"] = -90,
						["ry"] = 180,
						["time"] = 1,
					},
					["name"] = [[Set Camera Position/Direction]],
				},
				[4] = {
					["logicType"] = [[ConvoMessageAction]],
					["args"] = {
						["message"] = [[... non porti le unità ad est, il passaggio è tagliato da una massiccia linea difensiva. Per disabilitarla ...]],
						["fontSize"] = 14,
						["time"] = 180,
						["image"] = [[Avatar_stazione.png]],
						["imageWidth"] = 145,
						["imageHeight"] = 180,
					},
					["name"] = [[Convo Message]],
				},
				[5] = {
					["logicType"] = [[StartCountdownAction]],
					["args"] = {
						["countdown"] = [[009_parlato: shion conquistata da legione asiatica]],
						["display"] = false,
						["frames"] = 180,
					},
					["name"] = [[Start Countdown]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[25] = {
			["name"] = [[009_parlato: shion conquistata da legione asiatica]],
			["logic"] = {
				[1] = {
					["logicType"] = [[MakeUnitsAlwaysVisibleAction]],
					["args"] = {
						["group"] = [[asi_leg_power]],
						["value"] = true,
					},
					["name"] = [[Make Units Always Visible]],
				},
				[2] = {
					["logicType"] = [[CountdownEndedCondition]],
					["args"] = {
						["countdown"] = [[009_parlato: shion conquistata da legione asiatica]],
					},
					["name"] = [[Countdown Ended: 009_parlato: shion conquistata da legione asiatica]],
				},
				[3] = {
					["logicType"] = [[ConvoMessageAction]],
					["args"] = {
						["message"] = [[... dovrete distruggere le fonti energetiche ad Ovest...]],
						["fontSize"] = 14,
						["time"] = 180,
						["image"] = [[Avatar_stazione.png]],
						["imageWidth"] = 145,
						["imageHeight"] = 180,
					},
					["name"] = [[Convo Message]],
				},
				[4] = {
					["logicType"] = [[StartCountdownAction]],
					["args"] = {
						["countdown"] = [[010_parlato: shion conquistata da legione asiatica]],
						["display"] = false,
						["frames"] = 180,
					},
					["name"] = [[Start Countdown]],
				},
				[5] = {
					["logicType"] = [[SetCameraPosDirAction]],
					["args"] = {
						["px"] = 11000,
						["py"] = 2500,
						["pz"] = 6730,
						["rx"] = -90,
						["ry"] = 180,
						["time"] = 1,
					},
					["name"] = [[Set Camera Position/Direction]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[26] = {
			["name"] = [[010_parlato: shion conquistata da legione asiatica]],
			["logic"] = {
				[1] = {
					["logicType"] = [[CountdownEndedCondition]],
					["args"] = {
						["countdown"] = [[010_parlato: shion conquistata da legione asiatica]],
					},
					["name"] = [[Countdown Ended: 010_parlato: shion conquistata da legione asiatica]],
				},
				[2] = {
					["logicType"] = [[ConvoMessageAction]],
					["args"] = {
						["message"] = [[... solo così potrete raggiungere la base dell' EU Force. Buona fortuna!]],
						["fontSize"] = 14,
						["time"] = 180,
						["image"] = [[Avatar_stazione.png]],
						["imageWidth"] = 145,
						["imageHeight"] = 180,
					},
					["name"] = [[Convo Message]],
				},
				[3] = {
					["logicType"] = [[SetCameraPosDirAction]],
					["args"] = {
						["px"] = 3061,
						["py"] = 5000,
						["pz"] = 9952,
						["rx"] = -90,
						["ry"] = 180,
						["time"] = 1,
					},
					["name"] = [[Set Camera Position/Direction]],
				},
				[4] = {
					["logicType"] = [[StartCountdownAction]],
					["args"] = {
						["countdown"] = [[011_parlato: shion conquistata da legione asiatica]],
						["display"] = false,
						["frames"] = 180,
					},
					["name"] = [[Start Countdown: 011_parlato: shion conquistata da legione asiatica]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[27] = {
			["name"] = [[011_parlato: shion conquistata da legione asiatica]],
			["logic"] = {
				[1] = {
					["logicType"] = [[CountdownEndedCondition]],
					["args"] = {
						["countdown"] = [[011_parlato: shion conquistata da legione asiatica]],
					},
					["name"] = [[Countdown Ended:011_parlato: shion conquistata da legione asiatica]],
				},
				[2] = {
					["logicType"] = [[LeaveCutsceneAction]],
					["args"] = {
						["instant"] = false,
					},
					["name"] = [[Leave Cutscene]],
				},
				[3] = {
					["logicType"] = [[RestoreCameraStateAction]],
					["args"] = {},
					["name"] = [[Restore Camera State]],
				},
				[4] = {
					["logicType"] = [[CreateUnitsAction]],
					["args"] = {
						["units"] = {
							[1] = {
								["unitDefName"] = [[corgator]],
								["x"] = 9176,
								["y"] = 8208,
								["player"] = 1,
								["groups"] = {
									["asian_legion_001"] = true,
								},
								["heading"] = 269.768108672766,
								["isGhost"] = false,
							},
							[2] = {
								["unitDefName"] = [[corgator]],
								["x"] = 9216,
								["y"] = 8208,
								["player"] = 1,
								["groups"] = {
									["asian_legion_001"] = true,
								},
								["heading"] = 271.356236389614,
								["isGhost"] = false,
							},
							[3] = {
								["unitDefName"] = [[corgator]],
								["x"] = 9248,
								["y"] = 8208,
								["player"] = 1,
								["groups"] = {
									["asian_legion_001"] = true,
								},
								["heading"] = 263.184202393427,
								["isGhost"] = false,
							},
							[4] = {
								["unitDefName"] = [[corgator]],
								["x"] = 9176,
								["y"] = 8248,
								["player"] = 1,
								["groups"] = {
									["asian_legion_001"] = true,
								},
								["heading"] = 269.388575635086,
								["isGhost"] = false,
							},
							[5] = {
								["unitDefName"] = [[corgator]],
								["x"] = 9216,
								["y"] = 8240,
								["player"] = 1,
								["groups"] = {
									["asian_legion_001"] = true,
								},
								["heading"] = 271.17967357519,
								["isGhost"] = false,
							},
							[6] = {
								["unitDefName"] = [[corgator]],
								["x"] = 9248,
								["y"] = 8240,
								["player"] = 1,
								["groups"] = {
									["asian_legion_001"] = true,
								},
								["heading"] = 268.671260414487,
								["isGhost"] = false,
							},
						},
						["useOrbitalDrop"] = false,
						["ceg"] = [[]],
					},
					["name"] = [[Create Units]],
				},
				[5] = {
					["logicType"] = [[GiveOrdersAction]],
					["args"] = {
						["orders"] = {
							[1] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 7549.4476620061,
									[2] = 0,
									[3] = 8274.58609279961,
								},
							},
							[2] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 7297.87276024388,
									[2] = 0,
									[3] = 9330.91626869843,
								},
							},
							[3] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 7111.68460488078,
									[2] = 0,
									[3] = 11373.0802573709,
								},
							},
						},
						["groups"] = {
							["_leg_as_sentinelle"] = true,
							["asian_legion_001"] = true,
						},
					},
					["name"] = [[Give Orders]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[28] = {
			["name"] = [[Logica: se oltrepasso shion, anche factory 2 e 4 iniziano a costruire]],
			["logic"] = {
				[1] = {
					["logicType"] = [[UnitsAreInAreaCondition]],
					["args"] = {
						["areas"] = {
							[1] = {
								["category"] = [[cylinder]],
								["x"] = 8862.48,
								["y"] = 8874.36,
								["r"] = 428.339491525122,
							},
						},
						["groups"] = {},
						["players"] = {
							[1] = 0,
							[2] = 2,
						},
						["number"] = 1,
					},
					["name"] = [[Units Are In Area]],
				},
				[2] = {
					["logicType"] = [[GiveFactoryOrdersAction]],
					["args"] = {
						["buildOrders"] = {
							[1] = [[corak]],
							[2] = [[corak]],
							[3] = [[corstorm]],
							[4] = [[corstorm]],
							[5] = [[corthud]],
							[6] = [[corthud]],
						},
						["builtUnitsGroups"] = {},
						["factoryGroups"] = {
							["factory2"] = true,
							["factory4"] = true,
						},
						["repeatOrders"] = true,
					},
					["name"] = [[Give Factory Orders]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[29] = {
			["name"] = [[dopo 30 min inizio attacco EUF from factory 7]],
			["logic"] = {
				[1] = {
					["logicType"] = [[CountdownEndedCondition]],
					["args"] = {
						["countdown"] = [[inizio attacco a EUF]],
					},
					["name"] = [[Countdown Ended]],
				},
				[2] = {
					["logicType"] = [[GiveFactoryOrdersAction]],
					["args"] = {
						["buildOrders"] = {
							[1] = [[corwolv]],
							[2] = [[corlevlr]],
							[3] = [[corraid]],
							[4] = [[corgarp]],
							[5] = [[cormist]],
						},
						["builtUnitsGroups"] = {},
						["factoryGroups"] = {
							["factory7"] = true,
						},
						["repeatOrders"] = true,
					},
					["name"] = [[Give Factory Orders]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[30] = {
			["name"] = [[Logica: se distruggo asi_leg_power -> add 1 to obj1]],
			["logic"] = {
				[1] = {
					["logicType"] = [[UnitDestroyedCondition]],
					["args"] = {
						["groups"] = {
							["asi_leg_power"] = true,
						},
					},
					["name"] = [[Unit Destroyed]],
				},
				[2] = {
					["logicType"] = [[ModifyCounterAction]],
					["args"] = {
						["counter"] = [[obj1_contatore asi_leg_power]],
						["action"] = [[Increase]],
						["value"] = 1,
					},
					["name"] = [[Modify Counter]],
				},
			},
			["maxOccurrences"] = 2,
			["enabled"] = true,
			["probability"] = 1,
		},
		[31] = {
			["name"] = [[Logica: se obj1 = 2 -> obiettivo completato]],
			["logic"] = {
				[1] = {
					["logicType"] = [[CounterModifiedCondition]],
					["args"] = {
						["counter"] = [[obj1_contatore asi_leg_power]],
						["condition"] = [[=]],
						["value"] = 2,
					},
					["name"] = [[Counter Modified]],
				},
				[2] = {
					["logicType"] = [[StartCountdownAction]],
					["args"] = {
						["countdown"] = [[012_parlato: shion conquistata da legione asiatica]],
						["display"] = false,
						["frames"] = 60,
					},
					["name"] = [[Start Countdown 012_parlato: shion conquistata da legione asiatica]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[32] = {
			["name"] = [[012_parlato: centrali elettriche distrutte]],
			["logic"] = {
				[1] = {
					["logicType"] = [[CountdownEndedCondition]],
					["args"] = {
						["countdown"] = [[012_parlato: shion conquistata da legione asiatica]],
					},
					["name"] = [[Countdown Ended]],
				},
				[2] = {
					["logicType"] = [[EnterCutsceneAction]],
					["args"] = {
						["instant"] = false,
					},
					["name"] = [[Enter Cutscene]],
				},
				[3] = {
					["logicType"] = [[SaveCameraStateAction]],
					["args"] = {},
					["name"] = [[Save Camera State]],
				},
				[4] = {
					["logicType"] = [[SetCameraPosDirAction]],
					["args"] = {
						["px"] = 11000,
						["py"] = 2000,
						["pz"] = 6700,
						["rx"] = -90,
						["ry"] = 180,
						["time"] = 1,
					},
					["name"] = [[Set Camera Position/Direction]],
				},
				[5] = {
					["logicType"] = [[StartCountdownAction]],
					["args"] = {
						["countdown"] = [[013_parlato: centrali elettriche distrutte]],
						["display"] = false,
						["frames"] = 180,
					},
					["name"] = [[Start Countdown]],
				},
				[6] = {
					["logicType"] = [[ConvoMessageAction]],
					["args"] = {
						["message"] = [[Buon lavoro comandante, ora che le centrali sono state distrutte...]],
						["fontSize"] = 14,
						["time"] = 180,
						["image"] = [[Avatar_stazione.png]],
						["imageWidth"] = 145,
						["imageHeight"] = 180,
					},
					["name"] = [[Convo Message]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[33] = {
			["name"] = [[013_parlato: centrali elettriche distrutte]],
			["logic"] = {
				[1] = {
					["logicType"] = [[CountdownEndedCondition]],
					["args"] = {
						["countdown"] = [[013_parlato: centrali elettriche distrutte]],
					},
					["name"] = [[Countdown Ended]],
				},
				[2] = {
					["logicType"] = [[ConvoMessageAction]],
					["args"] = {
						["message"] = [[... possiamo eliminare anche la linea difensiva. Quelle torri colpiranno ancora fino a che non esauriranno completamente l'energia!]],
						["fontSize"] = 14,
						["time"] = 240,
						["image"] = [[Avatar_stazione.png]],
						["imageWidth"] = 145,
						["imageHeight"] = 180,
					},
					["name"] = [[Convo Message]],
				},
				[3] = {
					["logicType"] = [[StartCountdownAction]],
					["args"] = {
						["countdown"] = [[014_parlato: centrali elettriche distrutte]],
						["display"] = false,
						["frames"] = 240,
					},
					["name"] = [[Start Countdown]],
				},
				[4] = {
					["logicType"] = [[SetCameraPosDirAction]],
					["args"] = {
						["px"] = 6050,
						["py"] = 2000,
						["pz"] = 8210,
						["rx"] = -90,
						["ry"] = 180,
						["time"] = 1,
					},
					["name"] = [[Set Camera Position/Direction]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[34] = {
			["name"] = [[014_parlato: centrali elettriche distrutte]],
			["logic"] = {
				[1] = {
					["logicType"] = [[CountdownEndedCondition]],
					["args"] = {
						["countdown"] = [[014_parlato: centrali elettriche distrutte]],
					},
					["name"] = [[Countdown Ended]],
				},
				[2] = {
					["logicType"] = [[LeaveCutsceneAction]],
					["args"] = {
						["instant"] = false,
					},
					["name"] = [[Leave Cutscene]],
				},
				[3] = {
					["logicType"] = [[RestoreCameraStateAction]],
					["args"] = {},
					["name"] = [[Restore Camera State]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[35] = {
			["name"] = [[oltrepassando la linea difensiva legion alfa si devia il flusso di factory6  e si stoppa quello di 1,2,3 e 4]],
			["logic"] = {
				[1] = {
					["logicType"] = [[UnitsAreInAreaCondition]],
					["args"] = {
						["areas"] = {
							[1] = {
								["category"] = [[rectangle]],
								["x"] = 5904.36,
								["y"] = 7674.48,
								["width"] = 451.439999999999,
								["height"] = 1033.56,
							},
						},
						["groups"] = {},
						["players"] = {
							[1] = 0,
							[2] = 2,
						},
						["number"] = 1,
					},
					["name"] = [[Units Are In Area]],
				},
				[2] = {
					["logicType"] = [[DisableTriggersAction]],
					["args"] = {
						["triggers"] = {
							[1] = 7,
							[2] = 9,
							[3] = 10,
							[4] = 11,
							[5] = 12,
						},
					},
					["name"] = [[Disable Triggers]],
				},
				[3] = {
					["logicType"] = [[EnableTriggersAction]],
					["args"] = {
						["triggers"] = {
							[1] = 6,
						},
					},
					["name"] = [[Enable Triggers]],
				},
				[4] = {
					["logicType"] = [[GiveOrdersAction]],
					["args"] = {
						["orders"] = {
							[1] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 4296,
									[2] = 0,
									[3] = 6504,
								},
							},
						},
						["groups"] = {
							["nfa_nano002"] = true,
						},
					},
					["name"] = [[Give Orders]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[36] = {
			["name"] = [[015_Parlato: Distruzione totale linea difensiva legion alfa]],
			["logic"] = {
				[1] = {
					["logicType"] = [[CounterModifiedCondition]],
					["args"] = {
						["counter"] = [[asi_leg_difesa_alpha]],
						["condition"] = [[>=]],
						["value"] = 11,
					},
					["name"] = [[Counter Modified]],
				},
				[2] = {
					["logicType"] = [[ConvoMessageAction]],
					["args"] = {
						["message"] = [[Ottimo lavoro comandante! Ora che la linea difensiva della Legione è stata annientata... ]],
						["fontSize"] = 14,
						["time"] = 240,
						["image"] = [[Avatar_stazione.png]],
						["imageWidth"] = 145,
						["imageHeight"] = 180,
					},
					["name"] = [[Convo Message]],
				},
				[3] = {
					["logicType"] = [[SaveCameraStateAction]],
					["args"] = {},
					["name"] = [[Save Camera State]],
				},
				[4] = {
					["logicType"] = [[SetCameraPosDirAction]],
					["args"] = {
						["px"] = 6050,
						["py"] = 2000,
						["pz"] = 8200,
						["rx"] = -90,
						["ry"] = 180,
						["time"] = 1,
					},
					["name"] = [[Set Camera Position/Direction]],
				},
				[5] = {
					["logicType"] = [[StartCountdownAction]],
					["args"] = {
						["countdown"] = [[016_Parlato: distruzione totale linea difensiva legion alfa]],
						["display"] = false,
						["frames"] = 240,
					},
					["name"] = [[Start Countdown]],
				},
				[6] = {
					["logicType"] = [[EnterCutsceneAction]],
					["args"] = {
						["instant"] = false,
					},
					["name"] = [[Enter Cutscene]],
				},
				[7] = {
					["logicType"] = [[DisableTriggersAction]],
					["args"] = {
						["triggers"] = {
							[1] = 40,
						},
					},
					["name"] = [[Disable Triggers disabilito trigger "avvicinandosi all'EUForce senza aver distrutto...."]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[37] = {
			["name"] = [[016_Parlato: Distruzione totale linea difensiva legion alfa]],
			["logic"] = {
				[1] = {
					["logicType"] = [[SetCameraPosDirAction]],
					["args"] = {
						["px"] = 3200,
						["py"] = 5000,
						["pz"] = 9800,
						["rx"] = -90,
						["ry"] = 180,
						["time"] = 1,
					},
					["name"] = [[Set Camera Position/Direction]],
				},
				[2] = {
					["logicType"] = [[CountdownEndedCondition]],
					["args"] = {
						["countdown"] = [[016_Parlato: distruzione totale linea difensiva legion alfa]],
					},
					["name"] = [[Countdown Ended]],
				},
				[3] = {
					["logicType"] = [[ConvoMessageAction]],
					["args"] = {
						["message"] = [[... dovete  difendere la base dell' EU Force. Fatelo in attesa di ulteriori istruzioni, la legione intensificherà i suoi attacchi!]],
						["fontSize"] = 14,
						["time"] = 240,
						["image"] = [[Avatar_stazione.png]],
						["imageWidth"] = 145,
						["imageHeight"] = 180,
					},
					["name"] = [[Convo Message]],
				},
				[4] = {
					["logicType"] = [[StartCountdownAction]],
					["args"] = {
						["countdown"] = [[017_Parlato: Distruzione totale linea difensiva legion alfa]],
						["display"] = false,
						["frames"] = 240,
					},
					["name"] = [[Start Countdown]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[38] = {
			["name"] = [[017_Parlato: Distruzione totale linea difensiva legion alfa]],
			["logic"] = {
				[1] = {
					["logicType"] = [[CountdownEndedCondition]],
					["args"] = {
						["countdown"] = [[017_Parlato: Distruzione totale linea difensiva legion alfa]],
					},
					["name"] = [[Countdown Ended]],
				},
				[2] = {
					["logicType"] = [[RestoreCameraStateAction]],
					["args"] = {},
					["name"] = [[Restore Camera State]],
				},
				[3] = {
					["logicType"] = [[LeaveCutsceneAction]],
					["args"] = {
						["instant"] = false,
					},
					["name"] = [[Leave Cutscene]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[39] = {
			["name"] = [[****Avvicinandosi all' EUForce Creo altre unità Asian Legion beta e charlie]],
			["logic"] = {
				[1] = {
					["logicType"] = [[UnitsAreInAreaCondition]],
					["args"] = {
						["areas"] = {
							[1] = {
								["category"] = [[cylinder]],
								["x"] = 3243.24,
								["y"] = 9836.64,
								["r"] = 2376.02969981438,
							},
							[2] = {
								["category"] = [[rectangle]],
								["x"] = 3932.28,
								["y"] = 7151.76,
								["width"] = 2613.6,
								["height"] = 689.040000000001,
							},
							[3] = {
								["category"] = [[rectangle]],
								["x"] = 4264.92,
								["y"] = 7484.4,
								["width"] = 902.879999999997,
								["height"] = 1401.84,
							},
						},
						["groups"] = {},
						["players"] = {
							[1] = 0,
							[2] = 2,
						},
						["number"] = 1,
					},
					["name"] = [[Units Are In Area]],
				},
				[2] = {
					["logicType"] = [[CreateUnitsAction]],
					["args"] = {
						["units"] = {
							[1] = {
								["unitDefName"] = [[coradvsol]],
								["x"] = 4392,
								["y"] = 6080,
								["player"] = 4,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[2] = {
								["unitDefName"] = [[coradvsol]],
								["x"] = 4392,
								["y"] = 6144,
								["player"] = 4,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[3] = {
								["unitDefName"] = [[coradvsol]],
								["x"] = 4392,
								["y"] = 6208,
								["player"] = 4,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[4] = {
								["unitDefName"] = [[coradvsol]],
								["x"] = 4440,
								["y"] = 6328,
								["player"] = 4,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[5] = {
								["unitDefName"] = [[coradvsol]],
								["x"] = 4440,
								["y"] = 6384,
								["player"] = 4,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[6] = {
								["unitDefName"] = [[coradvsol]],
								["x"] = 4440,
								["y"] = 6440,
								["player"] = 4,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[7] = {
								["unitDefName"] = [[coradvsol]],
								["x"] = 4496,
								["y"] = 6320,
								["player"] = 4,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[8] = {
								["unitDefName"] = [[coradvsol]],
								["x"] = 4496,
								["y"] = 6384,
								["player"] = 4,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[9] = {
								["unitDefName"] = [[coradvsol]],
								["x"] = 4496,
								["y"] = 6448,
								["player"] = 4,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[10] = {
								["unitDefName"] = [[corpun]],
								["x"] = 4456,
								["y"] = 6584,
								["player"] = 4,
								["groups"] = {},
								["heading"] = 91.1584114433378,
								["isGhost"] = false,
							},
							[11] = {
								["unitDefName"] = [[corpun]],
								["x"] = 4608,
								["y"] = 6336,
								["player"] = 4,
								["groups"] = {},
								["heading"] = 89.8760545995668,
								["isGhost"] = false,
							},
							[12] = {
								["unitDefName"] = [[corpun]],
								["x"] = 4104,
								["y"] = 6984,
								["player"] = 4,
								["groups"] = {},
								["heading"] = 179.384203178699,
								["isGhost"] = false,
							},
							[13] = {
								["unitDefName"] = [[corpun]],
								["x"] = 4280,
								["y"] = 7016,
								["player"] = 4,
								["groups"] = {},
								["heading"] = 181.184448322592,
								["isGhost"] = false,
							},
							[14] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 5584,
								["y"] = 3280,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[15] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 5472,
								["y"] = 3328,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 179.892885119247,
								["isGhost"] = false,
							},
							[16] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 5688,
								["y"] = 3344,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 90.6872349655354,
								["isGhost"] = false,
							},
							[17] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 6312,
								["y"] = 2568,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[18] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 6264,
								["y"] = 2448,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 81.4415950942169,
								["isGhost"] = false,
							},
							[19] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 6672,
								["y"] = 2176,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 270.723822359811,
								["isGhost"] = false,
							},
							[20] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 6744,
								["y"] = 2104,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 89.427737913818,
								["isGhost"] = false,
							},
							[21] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 7208,
								["y"] = 2160,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[22] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 7272,
								["y"] = 2096,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 94.470094863959,
								["isGhost"] = false,
							},
							[23] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 8696,
								["y"] = 3728,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[24] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 8768,
								["y"] = 3784,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 85.4308677160573,
								["isGhost"] = false,
							},
							[25] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 9360,
								["y"] = 3552,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[26] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 9088,
								["y"] = 4232,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[27] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 8032,
								["y"] = 4088,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[28] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 7840,
								["y"] = 4152,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 86.3637857318833,
								["isGhost"] = false,
							},
							[29] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 9576,
								["y"] = 1784,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[30] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 10880,
								["y"] = 1424,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[31] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 10952,
								["y"] = 1304,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[32] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 10680,
								["y"] = 2360,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[33] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 11160,
								["y"] = 3904,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[34] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 11320,
								["y"] = 4024,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 263.969001293769,
								["isGhost"] = false,
							},
							[35] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 11208,
								["y"] = 4584,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 274.721139241939,
								["isGhost"] = false,
							},
							[36] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 11344,
								["y"] = 4536,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[37] = {
								["unitDefName"] = [[corexp]],
								["x"] = 8040,
								["y"] = 4016,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[38] = {
								["unitDefName"] = [[corexp]],
								["x"] = 7744,
								["y"] = 4160,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[39] = {
								["unitDefName"] = [[corexp]],
								["x"] = 9320,
								["y"] = 3480,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 264.538174118258,
								["isGhost"] = false,
							},
							[40] = {
								["unitDefName"] = [[corexp]],
								["x"] = 9240,
								["y"] = 3456,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[41] = {
								["unitDefName"] = [[corexp]],
								["x"] = 10608,
								["y"] = 2376,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 270.081586097303,
								["isGhost"] = false,
							},
							[42] = {
								["unitDefName"] = [[corexp]],
								["x"] = 11184,
								["y"] = 3968,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 269.733570757459,
								["isGhost"] = false,
							},
							[43] = {
								["unitDefName"] = [[corexp]],
								["x"] = 11312,
								["y"] = 4608,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 272.800103193305,
								["isGhost"] = false,
							},
							[44] = {
								["unitDefName"] = [[cormexp]],
								["x"] = 8704,
								["y"] = 3640,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[45] = {
								["unitDefName"] = [[cormexp]],
								["x"] = 9296,
								["y"] = 3400,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[46] = {
								["unitDefName"] = [[cormexp]],
								["x"] = 10584,
								["y"] = 2296,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[47] = {
								["unitDefName"] = [[cormexp]],
								["x"] = 5592,
								["y"] = 3392,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 178.672626244318,
								["isGhost"] = false,
							},
							[48] = {
								["unitDefName"] = [[cormexp]],
								["x"] = 4608,
								["y"] = 4144,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[49] = {
								["unitDefName"] = [[cormexp]],
								["x"] = 4184,
								["y"] = 4256,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[50] = {
								["unitDefName"] = [[cormexp]],
								["x"] = 3872,
								["y"] = 2280,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 177.638212487638,
								["isGhost"] = false,
							},
							[51] = {
								["unitDefName"] = [[cormexp]],
								["x"] = 3752,
								["y"] = 2360,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 90.6868615542216,
								["isGhost"] = false,
							},
							[52] = {
								["unitDefName"] = [[cormexp]],
								["x"] = 3280,
								["y"] = 3848,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[53] = {
								["unitDefName"] = [[cormexp]],
								["x"] = 3104,
								["y"] = 3856,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[54] = {
								["unitDefName"] = [[cormex]],
								["x"] = 3184,
								["y"] = 3896,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[55] = {
								["unitDefName"] = [[cormex]],
								["x"] = 3744,
								["y"] = 2248,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[56] = {
								["unitDefName"] = [[cormex]],
								["x"] = 10952,
								["y"] = 1400,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[57] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 4176,
								["y"] = 4392,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[58] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 4216,
								["y"] = 4528,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[59] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 4248,
								["y"] = 4440,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 88.4437850159302,
								["isGhost"] = false,
							},
							[60] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 4632,
								["y"] = 4232,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[61] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 4712,
								["y"] = 4200,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 90.3556587323848,
								["isGhost"] = false,
							},
							[62] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 4904,
								["y"] = 4392,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[63] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 4904,
								["y"] = 4504,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[64] = {
								["unitDefName"] = [[cormoho]],
								["x"] = 4992,
								["y"] = 4528,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[65] = {
								["unitDefName"] = [[cordoom]],
								["x"] = 6280,
								["y"] = 3456,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 180.499507165918,
								["isGhost"] = false,
							},
							[66] = {
								["unitDefName"] = [[cordoom]],
								["x"] = 6072,
								["y"] = 3456,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 181.586958745905,
								["isGhost"] = false,
							},
							[67] = {
								["unitDefName"] = [[cordoom]],
								["x"] = 6680,
								["y"] = 3456,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 178.834385627623,
								["isGhost"] = false,
							},
							[68] = {
								["unitDefName"] = [[cordoom]],
								["x"] = 7032,
								["y"] = 3456,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 180.829423737359,
								["isGhost"] = false,
							},
							[69] = {
								["unitDefName"] = [[cordoom]],
								["x"] = 7296,
								["y"] = 3680,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 266.683306663161,
								["isGhost"] = false,
							},
							[70] = {
								["unitDefName"] = [[cordoom]],
								["x"] = 7552,
								["y"] = 3960,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 268.080534494876,
								["isGhost"] = false,
							},
							[71] = {
								["unitDefName"] = [[cordoom]],
								["x"] = 7544,
								["y"] = 4320,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 271.455179546477,
								["isGhost"] = false,
							},
							[72] = {
								["unitDefName"] = [[cordoom]],
								["x"] = 7544,
								["y"] = 4632,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 267.963926469886,
								["isGhost"] = false,
							},
							[73] = {
								["unitDefName"] = [[cordoom]],
								["x"] = 5896,
								["y"] = 3288,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 180.64214294906,
								["isGhost"] = false,
							},
							[74] = {
								["unitDefName"] = [[cordoom]],
								["x"] = 5760,
								["y"] = 3144,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 269.469585617934,
								["isGhost"] = false,
							},
							[75] = {
								["unitDefName"] = [[cordoom]],
								["x"] = 5760,
								["y"] = 2808,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 267.849440109028,
								["isGhost"] = false,
							},
							[76] = {
								["unitDefName"] = [[coravp]],
								["x"] = 6544,
								["y"] = 2376,
								["player"] = 5,
								["groups"] = {
									["factory12"] = true,
								},
								["heading"] = 179.887751700075,
								["isGhost"] = false,
							},
							[77] = {
								["unitDefName"] = [[coralab]],
								["x"] = 6744,
								["y"] = 2376,
								["player"] = 5,
								["groups"] = {
									["factory11"] = true,
								},
								["heading"] = 179.163489770628,
								["isGhost"] = false,
							},
							[78] = {
								["unitDefName"] = [[corvp]],
								["x"] = 7008,
								["y"] = 2528,
								["player"] = 5,
								["groups"] = {
									["Factory9"] = true,
								},
								["heading"] = 268.997460218003,
								["isGhost"] = false,
							},
							[79] = {
								["unitDefName"] = [[corvp]],
								["x"] = 7008,
								["y"] = 2704,
								["player"] = 5,
								["groups"] = {
									["Factory9"] = true,
								},
								["heading"] = 268.948477286216,
								["isGhost"] = false,
							},
							[80] = {
								["unitDefName"] = [[corvp]],
								["x"] = 7008,
								["y"] = 2856,
								["player"] = 5,
								["groups"] = {
									["Factory9"] = true,
								},
								["heading"] = 268.701826619417,
								["isGhost"] = false,
							},
							[81] = {
								["unitDefName"] = [[corlab]],
								["x"] = 7416,
								["y"] = 2520,
								["player"] = 5,
								["groups"] = {
									["factory10"] = true,
								},
								["heading"] = 267.984503593958,
								["isGhost"] = false,
							},
							[82] = {
								["unitDefName"] = [[corlab]],
								["x"] = 7416,
								["y"] = 2688,
								["player"] = 5,
								["groups"] = {
									["factory10"] = true,
								},
								["heading"] = 269.493033744121,
								["isGhost"] = false,
							},
							[83] = {
								["unitDefName"] = [[corlab]],
								["x"] = 7416,
								["y"] = 2856,
								["player"] = 5,
								["groups"] = {
									["factory10"] = true,
								},
								["heading"] = 268.334182662848,
								["isGhost"] = false,
							},
							[84] = {
								["unitDefName"] = [[cordrag]],
								["x"] = 6352,
								["y"] = 4400,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[85] = {
								["unitDefName"] = [[cordrag]],
								["x"] = 6384,
								["y"] = 4400,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[86] = {
								["unitDefName"] = [[cordrag]],
								["x"] = 6416,
								["y"] = 4400,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[87] = {
								["unitDefName"] = [[cordrag]],
								["x"] = 6456,
								["y"] = 4400,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[88] = {
								["unitDefName"] = [[cordrag]],
								["x"] = 6488,
								["y"] = 4400,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[89] = {
								["unitDefName"] = [[cordrag]],
								["x"] = 6528,
								["y"] = 4400,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[90] = {
								["unitDefName"] = [[cordrag]],
								["x"] = 6560,
								["y"] = 4400,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[91] = {
								["unitDefName"] = [[cordrag]],
								["x"] = 6600,
								["y"] = 4400,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[92] = {
								["unitDefName"] = [[cordrag]],
								["x"] = 6632,
								["y"] = 4400,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[93] = {
								["unitDefName"] = [[corhlt]],
								["x"] = 6384,
								["y"] = 4360,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 181.859584876744,
								["isGhost"] = false,
							},
							[94] = {
								["unitDefName"] = [[corhlt]],
								["x"] = 6608,
								["y"] = 4352,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 180.474388747622,
								["isGhost"] = false,
							},
							[95] = {
								["unitDefName"] = [[cordoom]],
								["x"] = 5160,
								["y"] = 6728,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 179.528293088408,
								["isGhost"] = false,
							},
							[96] = {
								["unitDefName"] = [[cordoom]],
								["x"] = 5240,
								["y"] = 6768,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 176.865456176653,
								["isGhost"] = false,
							},
							[97] = {
								["unitDefName"] = [[cordoom]],
								["x"] = 5440,
								["y"] = 6824,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 181.677034913413,
								["isGhost"] = false,
							},
							[98] = {
								["unitDefName"] = [[cordoom]],
								["x"] = 5520,
								["y"] = 6848,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 181.814243919409,
								["isGhost"] = false,
							},
							[99] = {
								["unitDefName"] = [[corpun]],
								["x"] = 5160,
								["y"] = 6792,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 180.092619898653,
								["isGhost"] = false,
							},
							[100] = {
								["unitDefName"] = [[corpun]],
								["x"] = 5240,
								["y"] = 6832,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 178.91788695566,
								["isGhost"] = false,
							},
							[101] = {
								["unitDefName"] = [[corpun]],
								["x"] = 5432,
								["y"] = 6888,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 180.91436733856,
								["isGhost"] = false,
							},
							[102] = {
								["unitDefName"] = [[corpun]],
								["x"] = 5520,
								["y"] = 6912,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 179.528606048226,
								["isGhost"] = false,
							},
							[103] = {
								["unitDefName"] = [[corjamt]],
								["x"] = 5224,
								["y"] = 6680,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[104] = {
								["unitDefName"] = [[corjamt]],
								["x"] = 5488,
								["y"] = 6768,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[105] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 7112,
								["y"] = 2464,
								["player"] = 5,
								["groups"] = {
									["nanofactory_9"] = true,
								},
								["heading"] = 358.793365590658,
								["isGhost"] = false,
							},
							[106] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 7112,
								["y"] = 2512,
								["player"] = 5,
								["groups"] = {
									["nanofactory_9"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[107] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 7112,
								["y"] = 2560,
								["player"] = 5,
								["groups"] = {
									["nanofactory_9"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[108] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 7112,
								["y"] = 2600,
								["player"] = 5,
								["groups"] = {
									["nanofactory_9"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[109] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 7112,
								["y"] = 2648,
								["player"] = 5,
								["groups"] = {
									["nanofactory_9"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[110] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 7112,
								["y"] = 2696,
								["player"] = 5,
								["groups"] = {
									["nanofactory_9"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[111] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 7112,
								["y"] = 2744,
								["player"] = 5,
								["groups"] = {
									["nanofactory_9"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[112] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 7120,
								["y"] = 2792,
								["player"] = 5,
								["groups"] = {
									["nanofactory_9"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[113] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 7120,
								["y"] = 2840,
								["player"] = 5,
								["groups"] = {
									["nanofactory_9"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[114] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 7112,
								["y"] = 2896,
								["player"] = 5,
								["groups"] = {
									["nanofactory_9"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[115] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 7112,
								["y"] = 2936,
								["player"] = 5,
								["groups"] = {
									["nanofactory_9"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[116] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 7512,
								["y"] = 2448,
								["player"] = 5,
								["groups"] = {
									["nanofactory_10"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[117] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 7512,
								["y"] = 2496,
								["player"] = 5,
								["groups"] = {
									["nanofactory_10"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[118] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 7512,
								["y"] = 2544,
								["player"] = 5,
								["groups"] = {
									["nanofactory_10"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[119] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 7512,
								["y"] = 2592,
								["player"] = 5,
								["groups"] = {
									["nanofactory_10"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[120] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 7512,
								["y"] = 2640,
								["player"] = 5,
								["groups"] = {
									["nanofactory_10"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[121] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 7512,
								["y"] = 2688,
								["player"] = 5,
								["groups"] = {
									["nanofactory_10"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[122] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 7512,
								["y"] = 2736,
								["player"] = 5,
								["groups"] = {
									["nanofactory_10"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[123] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 7512,
								["y"] = 2784,
								["player"] = 5,
								["groups"] = {
									["nanofactory_10"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[124] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 7512,
								["y"] = 2832,
								["player"] = 5,
								["groups"] = {
									["nanofactory_10"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[125] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 7512,
								["y"] = 2880,
								["player"] = 5,
								["groups"] = {
									["nanofactory_10"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[126] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 7512,
								["y"] = 2936,
								["player"] = 5,
								["groups"] = {
									["nanofactory_10"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[127] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 6424,
								["y"] = 2280,
								["player"] = 5,
								["groups"] = {
									["cornano_11"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[128] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 6464,
								["y"] = 2280,
								["player"] = 5,
								["groups"] = {
									["cornano_11"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[129] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 6512,
								["y"] = 2280,
								["player"] = 5,
								["groups"] = {
									["cornano_11"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[130] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 6560,
								["y"] = 2280,
								["player"] = 5,
								["groups"] = {
									["cornano_11"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[131] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 6608,
								["y"] = 2280,
								["player"] = 5,
								["groups"] = {
									["cornano_11"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[132] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 6656,
								["y"] = 2280,
								["player"] = 5,
								["groups"] = {
									["cornano_11"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[133] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 6704,
								["y"] = 2280,
								["player"] = 5,
								["groups"] = {
									["cornano_11"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[134] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 6752,
								["y"] = 2280,
								["player"] = 5,
								["groups"] = {
									["cornano_11"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[135] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 6808,
								["y"] = 2280,
								["player"] = 5,
								["groups"] = {
									["cornano_11"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[136] = {
								["unitDefName"] = [[cornanotc]],
								["x"] = 6848,
								["y"] = 2280,
								["player"] = 5,
								["groups"] = {
									["cornano_11"] = true,
								},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[137] = {
								["unitDefName"] = [[corasp]],
								["x"] = 7232,
								["y"] = 3208,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[138] = {
								["unitDefName"] = [[corasp]],
								["x"] = 7408,
								["y"] = 3208,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[139] = {
								["unitDefName"] = [[corasp]],
								["x"] = 7056,
								["y"] = 3208,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[140] = {
								["unitDefName"] = [[corarad]],
								["x"] = 6736,
								["y"] = 3456,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[141] = {
								["unitDefName"] = [[corarad]],
								["x"] = 6616,
								["y"] = 4304,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[142] = {
								["unitDefName"] = [[corfus]],
								["x"] = 6664,
								["y"] = 1480,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[143] = {
								["unitDefName"] = [[corfus]],
								["x"] = 6552,
								["y"] = 1480,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[144] = {
								["unitDefName"] = [[corfus]],
								["x"] = 6448,
								["y"] = 1480,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[145] = {
								["unitDefName"] = [[corfus]],
								["x"] = 6336,
								["y"] = 1480,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[146] = {
								["unitDefName"] = [[corhlt]],
								["x"] = 6296,
								["y"] = 3632,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 180.276231827133,
								["isGhost"] = false,
							},
							[147] = {
								["unitDefName"] = [[corhlt]],
								["x"] = 6672,
								["y"] = 3632,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 177.798161137102,
								["isGhost"] = false,
							},
							[148] = {
								["unitDefName"] = [[corpun]],
								["x"] = 6312,
								["y"] = 4344,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 179.744490831601,
								["isGhost"] = false,
							},
							[149] = {
								["unitDefName"] = [[corpun]],
								["x"] = 6696,
								["y"] = 4344,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 180.828328501215,
								["isGhost"] = false,
							},
							[150] = {
								["unitDefName"] = [[coruwadves]],
								["x"] = 6040,
								["y"] = 1456,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[151] = {
								["unitDefName"] = [[coruwadves]],
								["x"] = 5952,
								["y"] = 1456,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
							[152] = {
								["unitDefName"] = [[coruwadves]],
								["x"] = 5864,
								["y"] = 1448,
								["player"] = 5,
								["groups"] = {},
								["heading"] = 0,
								["isGhost"] = false,
							},
						},
						["useOrbitalDrop"] = false,
						["ceg"] = [[]],
					},
					["name"] = [[Create Units Bravo e charlie]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[40] = {
			["name"] = [[Avvicinandosi all'EUForce senza aver distrutto la linea difensiva, disabilito i trigger 015 parlato e successivi]],
			["logic"] = {
				[1] = {
					["logicType"] = [[UnitsAreInAreaCondition]],
					["args"] = {
						["areas"] = {
							[1] = {
								["category"] = [[cylinder]],
								["x"] = 3267,
								["y"] = 9801,
								["r"] = 1500.08228894284,
							},
						},
						["groups"] = {},
						["players"] = {
							[1] = 0,
							[2] = 2,
						},
						["number"] = 1,
					},
					["name"] = [[Units Are In Area]],
				},
				[2] = {
					["logicType"] = [[DisableTriggersAction]],
					["args"] = {
						["triggers"] = {
							[1] = 3,
							[2] = 36,
							[3] = 37,
							[4] = 38,
						},
					},
					["name"] = [[Disable Triggers]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[41] = {
			["name"] = [[Parlato: Mi avvicino all' EU Force, inizio obiettivo 2  + factory 9 e 10]],
			["logic"] = {
				[1] = {
					["logicType"] = [[UnitsAreInAreaCondition]],
					["args"] = {
						["areas"] = {
							[1] = {
								["category"] = [[cylinder]],
								["x"] = 3065.04,
								["y"] = 10014.84,
								["r"] = 1201.46687145339,
							},
						},
						["groups"] = {},
						["players"] = {
							[1] = 0,
							[2] = 2,
						},
						["number"] = 1,
					},
					["name"] = [[Units Are In Area]],
				},
				[2] = {
					["logicType"] = [[SaveCameraStateAction]],
					["args"] = {},
					["name"] = [[Save Camera State]],
				},
				[3] = {
					["logicType"] = [[SetCameraPosDirAction]],
					["args"] = {
						["px"] = 3500,
						["py"] = 2000,
						["pz"] = 9650,
						["rx"] = -90,
						["ry"] = 180,
						["time"] = 1,
					},
					["name"] = [[Set Camera Position/Direction]],
				},
				[4] = {
					["logicType"] = [[EnterCutsceneAction]],
					["args"] = {
						["instant"] = false,
					},
					["name"] = [[Enter Cutscene]],
				},
				[5] = {
					["logicType"] = [[ConvoMessageAction]],
					["args"] = {
						["message"] = [[Ben arrivato comandante! Sono Roger Mill, capitano di questo avamposto EU Force... Qui la situazione è critica! Siamo a corto di unità e abbiamo i civili da salvare...]],
						["fontSize"] = 14,
						["time"] = 240,
						["image"] = [[Avatar_EUF.png]],
						["imageWidth"] = 145,
						["imageHeight"] = 180,
					},
					["name"] = [[Convo Message]],
				},
				[6] = {
					["logicType"] = [[StartCountdownAction]],
					["args"] = {
						["countdown"] = [[018_Parlato: Distruzione totale linea difensiva legion alfa]],
						["display"] = false,
						["frames"] = 240,
					},
					["name"] = [[Start Countdown]],
				},
				[7] = {
					["logicType"] = [[GiveFactoryOrdersAction]],
					["args"] = {
						["buildOrders"] = {
							[1] = [[corraid]],
							[2] = [[corgarp]],
							[3] = [[corlevlr]],
							[4] = [[corwolv]],
							[5] = [[cormist]],
							[6] = [[corak]],
							[7] = [[corstorm]],
							[8] = [[corthud]],
						},
						["builtUnitsGroups"] = {},
						["factoryGroups"] = {
							["Factory9"] = true,
							["factory10"] = true,
						},
						["repeatOrders"] = false,
					},
					["name"] = [[Give Factory Orders factory 9 e 10]],
				},
				[8] = {
					["logicType"] = [[GiveOrdersAction]],
					["args"] = {
						["orders"] = {
							[1] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 6756.82469572211,
									[2] = 0,
									[3] = 2856.79311584491,
								},
							},
						},
						["groups"] = {},
					},
					["name"] = [[Give Orders factory9]],
				},
				[9] = {
					["logicType"] = [[GiveOrdersAction]],
					["args"] = {
						["orders"] = {
							[1] = {
								["orderType"] = [[MOVE]],
								["args"] = {
									[1] = 7251.48185784593,
									[2] = 0,
									[3] = 2691.11269582382,
								},
							},
						},
						["groups"] = {},
					},
					["name"] = [[Give Orders factory 10]],
				},
				[10] = {
					["logicType"] = [[GiveOrdersAction]],
					["args"] = {
						["orders"] = {
							[1] = {
								["orderType"] = [[PATROL]],
								["args"] = {
									[1] = 6768.24156862946,
									[2] = 0,
									[3] = 2652.79643022519,
								},
							},
						},
						["groups"] = {
							["nanofactory_10"] = true,
							["nanofactory_9"] = true,
						},
					},
					["name"] = [[Give Orders cornano 9 e 10]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[42] = {
			["name"] = [[018_Parlato: Distruzione totale linea difensiva legion alfa]],
			["logic"] = {
				[1] = {
					["logicType"] = [[CountdownEndedCondition]],
					["args"] = {
						["countdown"] = [[018_Parlato: Distruzione totale linea difensiva legion alfa]],
					},
					["name"] = [[Countdown Ended]],
				},
				[2] = {
					["logicType"] = [[ConvoMessageAction]],
					["args"] = {
						["message"] = [[Stiamo vedendo dai satelliti la situazione. Comandante, cerchi di mantenere le difese in Shion e proteggere  l'EU Force fino a che non stabiliamo un piano di evaquazione.]],
						["fontSize"] = 14,
						["time"] = 240,
						["image"] = [[Avatar_stazione.png]],
						["imageWidth"] = 145,
						["imageHeight"] = 180,
					},
					["name"] = [[Convo Message]],
				},
				[3] = {
					["logicType"] = [[StartCountdownAction]],
					["args"] = {
						["countdown"] = [[019_Parlato: Distruzione totale linea difensiva legion alfa]],
						["display"] = false,
						["frames"] = 240,
					},
					["name"] = [[Start Countdown]],
				},
				[4] = {
					["logicType"] = [[SetCameraPosDirAction]],
					["args"] = {
						["px"] = 3500,
						["py"] = 5000,
						["pz"] = 9650,
						["rx"] = -90,
						["ry"] = 180,
						["time"] = 6,
					},
					["name"] = [[Set Camera Position/Direction]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[43] = {
			["name"] = [[019_Parlato: Distruzione totale linea difensiva legion alfa]],
			["logic"] = {
				[1] = {
					["logicType"] = [[CountdownEndedCondition]],
					["args"] = {
						["countdown"] = [[019_Parlato: Distruzione totale linea difensiva legion alfa]],
					},
					["name"] = [[Countdown Ended]],
				},
				[2] = {
					["logicType"] = [[LeaveCutsceneAction]],
					["args"] = {
						["instant"] = false,
					},
					["name"] = [[Leave Cutscene]],
				},
				[3] = {
					["logicType"] = [[RestoreCameraStateAction]],
					["args"] = {},
					["name"] = [[Restore Camera State]],
				},
				[4] = {
					["logicType"] = [[StartCountdownAction]],
					["args"] = {
						["countdown"] = [[020_parlato: obiettivo 2_ piano evaquazione]],
						["display"] = false,
						["frames"] = 2700,
					},
					["name"] = [[Start Countdown 020_parlato: obiettivo 2_ piano evaquazione]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[44] = {
			["name"] = [[020_parlato: obiettivo 2_ piano evaquazione]],
			["logic"] = {
				[1] = {
					["logicType"] = [[CountdownEndedCondition]],
					["args"] = {
						["countdown"] = [[020_parlato: obiettivo 2_ piano evaquazione]],
					},
					["name"] = [[Countdown Ended]],
				},
				[2] = {
					["logicType"] = [[SaveCameraStateAction]],
					["args"] = {},
					["name"] = [[Save Camera State]],
				},
				[3] = {
					["logicType"] = [[EnterCutsceneAction]],
					["args"] = {
						["instant"] = false,
					},
					["name"] = [[Enter Cutscene]],
				},
				[4] = {
					["logicType"] = [[SetCameraPosDirAction]],
					["args"] = {
						["px"] = 9550,
						["py"] = 3000,
						["pz"] = 7370,
						["rx"] = -90,
						["ry"] = 180,
						["time"] = 1,
					},
					["name"] = [[Set Camera Position/Direction]],
				},
				[5] = {
					["logicType"] = [[ConvoMessageAction]],
					["args"] = {
						["message"] = [[Comandante, dobbiamo attivare lo spazioporto sito in Shion. Una volta attivo potremo evaquare i civili e portarvi i rinfornimenti necessari...]],
						["fontSize"] = 14,
						["time"] = 240,
						["image"] = [[Avatar_stazione.png]],
						["imageWidth"] = 145,
						["imageHeight"] = 180,
					},
					["name"] = [[Convo Message]],
				},
				[6] = {
					["logicType"] = [[StartCountdownAction]],
					["args"] = {
						["countdown"] = [[021_parlato: riparare base EUF]],
						["display"] = true,
						["frames"] = 240,
					},
					["name"] = [[Start Countdown]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[45] = {
			["name"] = [[021_parlato: abilitare base EUF]],
			["logic"] = {
				[1] = {
					["logicType"] = [[CountdownEndedCondition]],
					["args"] = {
						["countdown"] = [[021_parlato: riparare base EUF]],
					},
					["name"] = [[Countdown Ended]],
				},
				[2] = {
					["logicType"] = [[ConvoMessageAction]],
					["args"] = {
						["message"] = [[...Per attivare lo spazioporto sono necessari i k-bot "medic" dell'EUF. Avvicinatevi alle fabbriche dell'EUF per prenderne il controllo, saremo così in grado di produrre queste unità. Seguiranno aggiornamenti.]],
						["fontSize"] = 14,
						["time"] = 240,
						["image"] = [[Avatar_stazione.png]],
						["imageWidth"] = 145,
						["imageHeight"] = 180,
					},
					["name"] = [[Convo Message]],
				},
				[3] = {
					["logicType"] = [[StartCountdownAction]],
					["args"] = {
						["countdown"] = [[022_parlato: riparare base EUF]],
						["display"] = false,
						["frames"] = 240,
					},
					["name"] = [[Start Countdown]],
				},
				[4] = {
					["logicType"] = [[SetCameraPosDirAction]],
					["args"] = {
						["px"] = 3237,
						["py"] = 1500,
						["pz"] = 10021,
						["rx"] = -90,
						["ry"] = 180,
						["time"] = 1,
					},
					["name"] = [[Set Camera Position/Direction]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[46] = {
			["name"] = [[022_parlato: abilitare base EUF]],
			["logic"] = {
				[1] = {
					["logicType"] = [[CountdownEndedCondition]],
					["args"] = {
						["countdown"] = [[022_parlato: riparare base EUF]],
					},
					["name"] = [[Countdown Ended]],
				},
				[2] = {
					["logicType"] = [[RestoreCameraStateAction]],
					["args"] = {},
					["name"] = [[Restore Camera State]],
				},
				[3] = {
					["logicType"] = [[LeaveCutsceneAction]],
					["args"] = {
						["instant"] = false,
					},
					["name"] = [[Leave Cutscene]],
				},
				[4] = {
					["logicType"] = [[EnableTriggersAction]],
					["args"] = {
						["triggers"] = {
							[1] = 47,
						},
					},
					["name"] = [[Enable Triggers abilitare base uef se player 1 o 2 in area ************* correggere script]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[47] = {
			["name"] = [[abilitare base uef se player 1 o 2 in area ]],
			["logic"] = {
				[1] = {
					["logicType"] = [[UnitsAreInAreaCondition]],
					["args"] = {
						["areas"] = {
							[1] = {
								["category"] = [[rectangle]],
								["x"] = 3031.29233968793,
								["y"] = 9921.69982668939,
								["width"] = 462.606863084904,
								["height"] = 296.230710571914,
							},
						},
						["groups"] = {},
						["players"] = {
							[1] = 0,
							[2] = 2,
						},
						["number"] = 1,
					},
					["name"] = [[Units Are In Area]],
				},
				[2] = {
					["logicType"] = [[CustomAction2]],
					["args"] = {
						["codeStr"] = [[Spring.DestroyUnit(eu_factory,false,true)
eu_factory=Spring.CreateUnit("armblab",3237,0,10021,2,0)]],
						["synced"] = true,
					},
					["name"] = [[Custom Action (Alternate) trasferisco euflab a player 1]],
				},
				[3] = {
					["logicType"] = [[SetCameraPosDirAction]],
					["args"] = {
						["px"] = 3237,
						["py"] = 2000,
						["pz"] = 10021,
						["rx"] = -90,
						["ry"] = 180,
						["time"] = 1,
					},
					["name"] = [[Set Camera Position/Direction]],
				},
				[4] = {
					["logicType"] = [[EnterCutsceneAction]],
					["args"] = {
						["instant"] = false,
					},
					["name"] = [[Enter Cutscene]],
				},
				[5] = {
					["logicType"] = [[ConvoMessageAction]],
					["args"] = {
						["message"] = [[Ottimo lavoro comandante, ora costruisca i "MediK-bot" dell' EUF...]],
						["fontSize"] = 14,
						["time"] = 180,
						["image"] = [[Avatar_stazione.png]],
						["imageWidth"] = 145,
						["imageHeight"] = 180,
					},
					["name"] = [[Convo Message]],
				},
				[6] = {
					["logicType"] = [[StartCountdownAction]],
					["args"] = {
						["countdown"] = [[023_parlato: attivare spazioporto e dintorni]],
						["display"] = false,
						["frames"] = 180,
					},
					["name"] = [[Start Countdown]],
				},
				[7] = {
					["logicType"] = [[StartCountdownAction]],
					["args"] = {
						["countdown"] = [[023_parlato_bis]],
						["display"] = false,
						["frames"] = 30,
					},
					["name"] = [[Start Countdown]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = false,
			["probability"] = 1,
		},
		[48] = {
			["name"] = [[023_parlato_bis: avvicino la telecamera]],
			["logic"] = {
				[1] = {
					["logicType"] = [[CountdownEndedCondition]],
					["args"] = {
						["countdown"] = [[023_parlato_bis]],
					},
					["name"] = [[Countdown Ended]],
				},
				[2] = {
					["logicType"] = [[SetCameraPosDirAction]],
					["args"] = {
						["px"] = 3237,
						["py"] = 500,
						["pz"] = 10021,
						["rx"] = -90,
						["ry"] = 180,
						["time"] = 5,
					},
					["name"] = [[Set Camera Position/Direction]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[49] = {
			["name"] = [[023_parlato: attivare spazioporto e dintorni]],
			["logic"] = {
				[1] = {
					["logicType"] = [[CountdownEndedCondition]],
					["args"] = {
						["countdown"] = [[023_parlato: attivare spazioporto e dintorni]],
					},
					["name"] = [[Countdown Ended]],
				},
				[2] = {
					["logicType"] = [[ConvoMessageAction]],
					["args"] = {
						["message"] = [[...li mandi in Shion. Attivate lo spazioporto catturando la centralina di controllo...]],
						["fontSize"] = 14,
						["time"] = 180,
						["image"] = [[Avatar_stazione.png]],
						["imageWidth"] = 145,
						["imageHeight"] = 180,
					},
					["name"] = [[Convo Message]],
				},
				[3] = {
					["logicType"] = [[SetCameraPosDirAction]],
					["args"] = {
						["px"] = 9300,
						["py"] = 1700,
						["pz"] = 7537,
						["rx"] = -90,
						["ry"] = 180,
						["time"] = 1,
					},
					["name"] = [[Set Camera Position/Direction]],
				},
				[4] = {
					["logicType"] = [[StartCountdownAction]],
					["args"] = {
						["countdown"] = [[024_parlato: attivare spazioporto e dintorni]],
						["display"] = false,
						["frames"] = 180,
					},
					["name"] = [[Start Countdown 024_parlato: attivare spazioporto e dintorni]],
				},
				[5] = {
					["logicType"] = [[StartCountdownAction]],
					["args"] = {
						["countdown"] = [[024_bis: avvicino la telecamera]],
						["display"] = false,
						["frames"] = 30,
					},
					["name"] = [[Start Countdown 024_bis: avvicino la telecamera]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[50] = {
			["name"] = [[024_bis: avvicino la telecamera]],
			["logic"] = {
				[1] = {
					["logicType"] = [[CountdownEndedCondition]],
					["args"] = {
						["countdown"] = [[024_bis: avvicino la telecamera]],
					},
					["name"] = [[Countdown Ended]],
				},
				[2] = {
					["logicType"] = [[SetCameraPosDirAction]],
					["args"] = {
						["px"] = 9300,
						["py"] = 500,
						["pz"] = 7537,
						["rx"] = -90,
						["ry"] = 180,
						["time"] = 5,
					},
					["name"] = [[Set Camera Position/Direction]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[51] = {
			["name"] = [[024_parlato: attivare spazioporto e dintorni]],
			["logic"] = {
				[1] = {
					["logicType"] = [[CountdownEndedCondition]],
					["args"] = {
						["countdown"] = [[024_parlato: attivare spazioporto e dintorni]],
					},
					["name"] = [[Countdown Ended]],
				},
				[2] = {
					["logicType"] = [[SetCameraPosDirAction]],
					["args"] = {
						["px"] = 2000,
						["py"] = 3000,
						["pz"] = 10500,
						["rx"] = -90,
						["ry"] = 180,
						["time"] = 1,
					},
					["name"] = [[Set Camera Position/Direction]],
				},
				[3] = {
					["logicType"] = [[ConvoMessageAction]],
					["args"] = {
						["message"] = [[Potete anche attivare le batterie missilistiche ad ovest e a sud catturando le rispettive centraline. ]],
						["fontSize"] = 14,
						["time"] = 180,
						["image"] = [[Avatar_stazione.png]],
						["imageWidth"] = 145,
						["imageHeight"] = 180,
					},
					["name"] = [[Convo Message]],
				},
				[4] = {
					["logicType"] = [[StartCountdownAction]],
					["args"] = {
						["countdown"] = [[025_parlato: attivare spazioporto e dintorni]],
						["display"] = false,
						["frames"] = 180,
					},
					["name"] = [[Start Countdown]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[52] = {
			["name"] = [[025_parlato: attivare spazioporto e dintorni]],
			["logic"] = {
				[1] = {
					["logicType"] = [[CountdownEndedCondition]],
					["args"] = {
						["countdown"] = [[025_parlato: attivare spazioporto e dintorni]],
					},
					["name"] = [[Countdown Ended]],
				},
				[2] = {
					["logicType"] = [[RestoreCameraStateAction]],
					["args"] = {},
					["name"] = [[Restore Camera State]],
				},
				[3] = {
					["logicType"] = [[LeaveCutsceneAction]],
					["args"] = {
						["instant"] = false,
					},
					["name"] = [[Leave Cutscene]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
		[53] = {
			["name"] = [[Trigger 1]],
			["logic"] = {
				[1] = {
					["logicType"] = [[CustomAction2]],
					["args"] = {
						["codeStr"] = [[Spring.DestroyUnit(spazioporto,false,true)
spazioporto_din=Spring.CreateUnit("armspazioportodin",9550,0,7350,0,0)]],
						["synced"] = true,
					},
					["name"] = [[Custom Action (Alternate)]],
				},
				[2] = {
					["logicType"] = [[CustomCondition]],
					["args"] = {},
					["name"] = [[catturaspazioporto]],
				},
			},
			["maxOccurrences"] = 1,
			["enabled"] = true,
			["probability"] = 1,
		},
	},
	["startPlayer"] = 0,
	["disabledUnits"] = {},
	["scoringMethod"] = [[]],
	["counters"] = {
		[1] = [[obj1_contatore asi_leg_power]],
		[2] = [[asi_leg_difesa_alpha]],
	},
	["regions"] = {
		[1] = {
			["areas"] = {
				[1] = {
					["category"] = [[rectangle]],
					["x"] = 8090.28,
					["y"] = 9527.76,
					["width"] = 439.56,
					["height"] = 403.920000000001,
				},
			},
			["name"] = [[factory1]],
		},
		[2] = {
			["areas"] = {
				[1] = {
					["category"] = [[rectangle]],
					["x"] = 9634.68,
					["y"] = 8826.84,
					["width"] = 0,
					["height"] = 0,
				},
				[2] = {
					["category"] = [[rectangle]],
					["x"] = 9603.49428767994,
					["y"] = 8541.72181692984,
					["width"] = 250.388134893305,
					["height"] = 367.658527185108,
				},
			},
			["name"] = [[factory2]],
		},
		[3] = {
			["areas"] = {
				[1] = {
					["category"] = [[rectangle]],
					["x"] = 9431.56079834758,
					["y"] = 7921.69123193337,
					["width"] = 286.943537508583,
					["height"] = 314.271493461782,
				},
			},
			["name"] = [[factory3]],
		},
		[4] = {
			["areas"] = {
				[1] = {
					["category"] = [[rectangle]],
					["x"] = 10943.0337233307,
					["y"] = 7365.42012388138,
					["width"] = 212.359862353744,
					["height"] = 312.038981417746,
				},
			},
			["name"] = [[factory4]],
		},
		[5] = {
			["areas"] = {
				[1] = {
					["category"] = [[rectangle]],
					["x"] = 5690.52,
					["y"] = 9207,
					["width"] = 510.839999999999,
					["height"] = 451.44,
				},
			},
			["name"] = [[factory5]],
		},
		[6] = {
			["areas"] = {
				[1] = {
					["category"] = [[rectangle]],
					["x"] = 4012.07291028446,
					["y"] = 6803.64997811815,
					["width"] = 414.477111597373,
					["height"] = 396.456367614879,
				},
			},
			["name"] = [[factory6]],
		},
		[7] = {
			["areas"] = {
				[1] = {
					["category"] = [[rectangle]],
					["x"] = 5354.27438540942,
					["y"] = 5767.90229976318,
					["width"] = 264.852656621779,
					["height"] = 268.122442505998,
				},
			},
			["name"] = [[factory7]],
		},
		[8] = {
			["areas"] = {
				[1] = {
					["category"] = [[rectangle]],
					["x"] = 6649.90522900801,
					["y"] = 2628.12950381694,
					["width"] = 291.151717557269,
					["height"] = 291.151717557268,
				},
			},
			["name"] = [[Factory9]],
		},
		[9] = {
			["areas"] = {
				[1] = {
					["category"] = [[rectangle]],
					["x"] = 7146.79694656506,
					["y"] = 2371.6305343512,
					["width"] = 218.01984732825,
					["height"] = 638.106870229023,
				},
			},
			["name"] = [[factory10]],
		},
	},
}
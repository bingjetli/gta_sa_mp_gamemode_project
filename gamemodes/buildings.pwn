/*
 * Buildings Module
 * 
 ****
 * max buildings = 100
 * constant array of buildings:
 *	static - invisible to other files except this one
 *	virtual world = id+1; used to determine current building
 *	entrance_pickup_x
 *	entrance_pickup_y
 *	entrance_pickup_z
 * 	entrance_destination_x
 * 	entrance_destination_y
 * 	entrance_destination_z
 * 	entrance_destination_facing_angle
 * 	entrance_destination_interior_id
 * 	exit_pickup_x
 * 	exit_pickup_y
 * 	exit_pickup_z
 * 	exit_destination_x
 * 	exit_destination_y
 * 	exit_destination_z
 * 	exit_destination_facing_angle
 *
 * constant array of pickups:
 *	static - invisible to other files except this one
 * 	caching all possible pickupids to link to buildings array
 * 	size 4096 (max pickups)
*/
#define MAX_BUILDINGS 100
#define MAX_CACHED_PICKUPS 4096
#define ENEX_MARKER_MODEL_ID 19197
#define ENEX_TELEPORT_COOLDOWN 3000 //miliseconds

enum ENUM_BUILDINGS_DATA {
	Float:ENTRY_PICKUP_X,
	Float:ENTRY_PICKUP_Y,
	Float:ENTRY_PICKUP_Z,
	Float:ENTRY_TARGET_X,
	Float:ENTRY_TARGET_Y,
	Float:ENTRY_TARGET_Z,
	Float:ENTRY_TARGET_FACING_ANGLE,
	ENTRY_TARGET_INTERIOR_ID,
	Float:EXIT_PICKUP_X,
	Float:EXIT_PICKUP_Y,
	Float:EXIT_PICKUP_Z,
	Float:EXIT_TARGET_X,
	Float:EXIT_TARGET_Y,
	Float:EXIT_TARGET_Z,
	Float:EXIT_TARGET_FACING_ANGLE,
	EXIT_TARGET_INTERIOR_ID
};

/*
 * GTASA_ENEX_DATA_STRUCTURE
 *
 * X1, Y1, Z1, ROT - entrance location
 * W1 - X width of entry
 * W2 - Y width of entry
 * C8 - constant 8
 * X2, Y2, Z2, ROT2 - exit location
 * INT - target interior number
 * FLAG - marker type
 * NAME - interior name/mission script
 * SKY - sky color changer
 * I2 - unknown interger flags, could be weather related
 * TIME_ON - enables the marker at this time 
 * TIME_OFF - diables the marker at this time
*/
enum ENUM_GTASA_ENEX_DATA {
	Float:X1,
	Float:Y1,
	Float:Z1,
	Float:ROT,
	Float:W1,
	Float:W2,
	C8,
	Float:X2,
	Float:Y2,
	Float:Z2,
	Float:ROT2,
	INT,
	FLAG,
	NAME[8],
	SKY,
	I2,
	TIME_ON,
	TIME_OFF
}

/*
 * GTA SA ENEX DATA 
 * extracted from .ipl files
 * table best viewed with a tabwidth of 4
 * structure preserved to make importing new enexs easier
 * importing enexs should have proper int to float conversions to prevent tag mismatches
*/
stock static const buildings_gta_enex[][ENUM_GTASA_ENEX_DATA] = {
//x1		 y1			 z1			 rot1			 w1			 w2			 c8	 x2			 y2			 z2			 rot2		 int flag	 name		 sky i2	 t1	 t2
//SFe
{-1883.2,	 865.473,	 34.2601,	 -0.855211,		 4.0,	   	 4.0,	   	 8,	 -1886.2,	 862.473,	 34.2601,	 129.0,		 0,	 4,		 "CLOTHGP",	 0,	 10, 0,	 24},
{-1808.69,	 945.863,	 23.8648,	 0.0,			 2.0,	   	 2.0,	   	 8,	 -1805.79,	 943.221,	 23.9148,	 3824.59,	 0,	 4,		 "FDPIZA",	 0,	 2,	 0,	 24},
{-2099.68,	 897.485,	 75.9661,	 0.0,			 2.0,	   	 2.76306,	 8,	 -2103.76,	 901.734,	 75.7161,	 4374.68,	 0,	 4,		 "SVSFBG",	 0,	 2,	 0,	 24},
{-2213.54,	 720.845,	 48.4262,	 0.0,			 2.0,	   	 1.14844,	 8,	 -2214.06,	 725.036,	 48.4262,	 36.0,		 0,	 4,		 "SVSFSM",	 0,	 2,	 0,	 24},
{-1673.01,	 1337.93,	 6.18842,	 -0.785398,		 2.24048,	 3.3855,	 8,	 -1689.35,	 1335.56,	 16.0,		 -48.0,		 0,	 0,		 "P69_ENT",	 0,	 2,	 0,	 24},
{-1690.75,	 1334.37,	 15.318,	 -2.35619,		 2.24048,	 1.3855,	 8,	 -1675.09,	 1335.0,	 6.31796,	 -222.0,	 0,	 0,		 "P69_ENT",	 0,	 2,	 0,	 24},
{-1700.01,	 1380.49,	 6.20434,	 -0.785398,		 1.48853,	 1.38013,	 8,	 -1701.83,	 1378.97,	 6.20434,	 3729.57,	 0,	 4,		 "DINER2",	 0,	 2,	 0,	 24},
{-1721.13,	 1359.01,	 6.19634,	 0.0,			 2.0,	   	 2.0,	   	 8,	 -1725.89,	 1359.34,	 6.19634,	 96.0,		 0,	 4,		 "FDPIZA",	 0,	 2,	 0,	 24},
{-1912.27,	 828.025,	 34.5615,	 -0.610865,		 2.0,	   	 2.0,	   	 8,	 -1910.26,	 830.598,	 34.2215,	 334.0,		 0,	 4,		 "FDBURG",	 0,	 2,	 0,	 24},
{-1694.76,	 951.599,	 24.2706,	 -0.785398,		 2.0,	   	 2.0,	   	 8,	 -1699.27,	 950.599,	 24.2706,	 92.0,		 0,	 4,		 "CSDESGN",	 0,	 2,	 0,	 24},
{-1749.35,	 869.279,	 24.0593,	 0.0,			 4.0,	   	 4.0,	   	 8,	 -1753.85,	 885.679,	 295.059,	 -65.0,		 0,	 0,		 "",		 0,	 2,	 0,	 24},
{-1753.75,	 883.965,	 294.645,	 0.0,			 1.0,	   	 1.0,	   	 8,	 -1749.38,	 865.158,	 24.1455,	 4152.66,	 0,	 0,		 "",		 0,	 2,	 0,	 24},
{-2084.21,	 1160.33,	 49.2421,	 0.0,			 2.0,	   	 2.0,	   	 8,	 -2084.41,	 1164.57,	 49.2421,	 362.0,		 0,	 4100,	 "SFHSS1",	 0,	 2,	 20, 6},
{-2139.85,	 1189.84,	 54.7634,	 0.0,			 2.0,	   	 2.0,	   	 8,	 -2140.05,	 1186.08,	 54.7634,	 179.0,		 0,	 4100,	 "LAHS2A",	 0,	 2,	 20, 6},
{-2152.4,	 1250.16,	 24.9503,	 0.0,			 2.0,	   	 2.0,	   	 8,	 -2152.6,	 1254.4,	 24.7503,	 362.0,		 0,	 4100,	 "LAHS2A",	 0,	 2,	 20, 6},
{-1955.25,	 1190.6,	 44.4531,	 0.0,			 2.0,	   	 2.0,	   	 8,	 -1955.44,	 1187.84,	 44.4531,	 180.0,		 0,	 4100,	 "LAHS2A",	 0,	 2,	 20, 6},
{-1913.32,	 1252.89,	 18.5367,	 0.0,			 2.0,	   	 2.0,	   	 8,	 -1913.51,	 1257.12,	 18.5367,	 362.0,		 0,	 4100,	 "SFHSS1",	 0,	 2,	 20, 6},
{-1820.62,	 1116.27,	 45.5432,	 0.0,			 2.0,	   	 2.0,	   	 8,	 -1820.82,	 1112.51,	 44.4732,	 180.0,		 0,	 4100,	 "SFHSS1",	 0,	 2,	 20, 6},
{-1742.78,	 1174.34,	 24.1582,	 0.0,			 2.0,	   	 2.0,	   	 8,	 -1742.97,	 1178.58,	 24.1582,	 362.0,		 0,	 4100,	 "SFHSS1",	 0,	 2,	 20, 6},
{-2157.2,	 889.192,	 79.0246,	 0.0,			 2.0,	   	 2.0,	   	 8,	 -2154.4,	 889.43,	 79.0246,	 274.0,		 0,	 4100,	 "SFHSS1",	 0,	 2,	 20, 6},
{-2234.16,	 830.667,	 53.5143,	 0.0,			 2.0,	   	 2.0,	   	 8,	 -2236.36,	 830.906,	 53.4143,	 92.0,		 0,	 4100,	 "SFHSS1",	 0,	 2,	 20, 6},
{-2159.69,	 1048.74,	 79.03,		 0.0,			 2.0,	   	 2.0,	   	 8,	 -2156.88,	 1048.98,	 79.03,		 280.0,		 0,	 4100,	 "SFHSS1",	 0,	 2,	 20, 6},
{-2239.22,	 962.248,	 65.6541,	 0.0,			 2.0,	   	 2.0,	   	 8,	 -2243.41,	 962.486,	 65.6541,	 89.0,		 0,	 4100,	 "SFHSS1",	 0,	 2,	 20, 6},
{-2112.58,	 745.657,	 68.582,	 0.0,			 2.0,	   	 2.0,	   	 8,	 -2112.78,	 742.895,	 68.582,	 180.0,		 0,	 4100,	 "SFHSS1",	 0,	 2,	 20, 6},
{-2058.97,	 889.859,	 60.9137,	 0.0,			 2.0,	   	 2.0,	   	 8,	 -2059.17,	 894.097,	 59.9137,	 362.0,		 0,	 4100,	 "LAHS1B",	 0,	 2,	 20, 6},
{-2205.27,	 743.061,	 49.4742,	 0.0,			 2.0,	   	 2.0,	   	 8,	 -2205.46,	 740.299,	 48.9742,	 185.0,		 0,	 4100,	 "SFHSS1",	 0,	 2,	 20, 6},
{-1815.84,	 618.678,	 34.2989,	 0.0,			 1.416,		 1.61584,	 8,	 -1814.64,	 615.402,	 34.2989,	 208.0,		 0,	 4,		 "FDCHICK",	 0,	 2,	 0,	 24},
{-1887.43,	 749.592,	 44.4658,	 0.0,			 1.6,		 1.6,		 8,	 -1890.11,	 749.592,	 44.4658,	 3691.82,	 0,	 4,		 "REST2",	 0,	 2,	 0,	 24},
//SFn
{-2636.13,	 2351.92,	 7.59756,	 0.0,			 2.0,	   	 2.0,	   	 8,	 -2633.13,	 2351.92,	 7.59756,	 -90.0,		 0,	 5126,	 "SFHSS1",	 0,	 2,	 23, 6},
{-2626.29,	 2359.75,	 8.00576,	 0.0,			 2.0,	   	 2.0,	   	 8,	 -2625.29,	 2359.75,	 8.00576,	 -90.0,		 0,	 5126,	 "SFHSS2",	 0,	 2,	 23, 6},
{-2627.09,	 2309.93,	 7.35039,	 0.0,			 2.0,	   	 2.0,	   	 8,	 -2624.09,	 2309.93,	 7.35039,	 -90.0,		 0,	 5126,	 "SFHSB1",	 0,	 2,	 23, 6},
{-2627.09,	 2283.33,	 7.3178,	 0.0,			 2.0,	   	 2.0,	   	 8,	 -2624.09,	 2283.33,	 7.3178,	 -90.0,		 0,	 5126,	 "SFHSM2",	 0,	 2,	 23, 6},
//SFs
{-2270.46,	 -155.957,	 34.3573,	 0.0,			 1.0,	   	 1.5,		 8,	 -2269.46,	 -155.957,	 34.3573,	 270.0,		 0,	 4,		 "GYM2",	 0,	 2,	 0,	 24},
{-2625.85,	 208.345,	 3.98935,	 0.0,			 1.6,		 1.0,		 8,	 -2625.85,	 209.143,	 3.98935,	 5400.06,	 0,	 4,		 "AMMUN1",	 0,	 2,	 0,	 24},
{-2671.53,	 258.344,	 3.64932,	 0.0,			 1.5,		 1.5,		 8,	 -2671.53,	 259.141,	 3.64932,	 5400.06,	 0,	 4,		 "FDCHICK",	 0,	 2,	 0,	 24},
{-2454.44,	 -135.879,	 25.2223,	 0.0,			 0.6,		 1.5,		 8,	 -2455.44,	 -135.879,	 25.2223,	 90.0,		 0,	 4,		 "SVSFMD",	 0,	 2,	 0,	 24},
{-2425.94,	 337.87,	 35.997,	 -0.523599,		 1.0,	   	 2.5,		 8,	 -2424.94,	 337.37,	 35.997,	 -118.0,	 0,	 4,		 "SVHOT1",	 0,	 2,	 0,	 24},
{-2571.18,	 246.698,	 9.64213,	 -0.846485,		 1.0,	   	 2.0,		 8,	 -2570.18,	 245.498,	 9.34213,	 -138.0,	 0,	 4,		 "BARBER2",	 0,	 2,	 0,	 24},
{-2463.06,	 132.287,	 34.198,	 -0.785398,		 3.0,	   	 2.0,		 8,	 -2462.06,	 133.287,	 34.198,	 5359.06,	 0,	 6,		 "FDREST1",	 0,	 2,	 0,	 24},
{-2551.79,	 193.778,	 5.21905,	 0.244346,		 2.0,	   	 2.0,		 8,	 -2553.79,	 193.778,	 5.21905,	 105.0,		 0,	 4,		 "BAR1",	 0,	 2,	 0,	 24},
{-2336.95,	 -166.646,	 34.3573,	 0.0,			 1.0,	   	 1.5,		 8,	 -2335.95,	 -166.646,	 34.3573,	 270.0,		 0,	 4,		 "FDBURG",	 0,	 2,	 0,	 24},
{-2491.98,	 -29.1065,	 24.817,	 0.00405009,	 1.5,		 1.5,		 8,	 -2494.48,	 -29.1065,	 24.817,	 90.0,		 0,	 4,		 "LACS1",	 0,	 2,	 0,	 24},
{-2491.98,	 -38.9587,	 24.817,	 0.00405009,	 1.5,		 1.5,		 8,	 -2494.48,	 -38.9587,	 24.817,	 90.0,		 0,	 4,		 "TATTO2",	 0,	 2,	 0,	 24},
{-2591.41,	 -95.538,	 3.44458,	 0.0,			 2.0,	   	 2.0,	   	 8,	 -2595.48,	 -95.538,	 3.44458,	 90.0,		 0,	 4102,	 "SFHSS2",	 0,	 2,	 20, 6},
{-2591.41,	 -158.542,	 3.36046,	 0.0,			 2.0,	   	 2.0,	   	 8,	 -2595.48,	 -158.542,	 3.36046,	 90.0,		 0,	 4102,	 "SFHSS1",	 0,	 2,	 20, 6},
{-2558.79,	 -79.623,	 10.0789,	 0.0,			 2.0,	   	 2.0,	   	 8,	 -2558.87,	 -76.623,	 9.85889,	 0.0,		 0,	 4102,	 "SFHSS1",	 0,	 2,	 20, 6},
{-2541.61,	 -145.321,	 14.7826,	 0.0,			 2.0,	   	 2.0,	   	 8,	 -2541.69,	 -142.321,	 14.8826,	 0.0,		 0,	 4102,	 "SFHSS2",	 0,	 2,	 20, 6},
{-2514.04,	 -170.797,	 24.2706,	 0.0,			 2.0,	   	 2.0,	   	 8,	 -2510.12,	 -170.797,	 24.6706,	 -90.0,		 0,	 4102,	 "SFHSS1",	 0,	 2,	 20, 6},
//SFSe
{-2027.73,	 -40.5488,	 37.8263,	 0.0,			 3.0,	   	 3.0,	   	 8,	 -2027.83,	 -44.0454,	 37.0263,	 4139.7,	 0,	 4,		 "SVSFBG",	 0,	 2,	 0,	 24},
{-2242.69,	 -88.2558,	 34.3578,	 0.0,			 1.6,		 1.6,		 8,	 -2245.38,	 -88.2558,	 34.3578,	 3691.82,	 0,	 4,		 "BAR2",	 0,	 2,	 0,	 24},
//SFw
{-2700.32,	 820.308,	 48.999,	 -1.5708,		 1.0,	   	 2.0,		 8,	 -2700.32,	 818.686,	 48.999,	 -180.0,	 0,	 4,		 "SVSFSM",	 0,	 2,	 0,	 24},
{-2375.32,	 910.293,	 44.4578,	 0.0,			 2.0,	   	 1.66492,	 8,	 -2377.32,	 909.293,	 44.4578,	 5507.58,	 0,	 4,		 "CSCHP",	 0,	 2,	 0,	 24},
{-2356.48,	 1008.01,	 49.9036,	 0.0,			 2.0,	   	 2.0,		 8,	 -2356.48,	 1005.14,	 49.9036,	 -180.0,	 0,	 4,		 "FDBURG",	 0,	 2,	 0,	 24},
{-2524.11,	 1216.16,	 36.4496,	 0.0,			 1.0,	   	 1.25293,	 8,	 -2521.86,	 1216.16,	 36.4496,	 -90.0,		 0,	 4,		 "DINER2",	 0,	 2,	 0,	 24},
{-2449.72,	 921.163,	 57.2093,	 -1.60131,		 1.0,	   	 2.0,	   	 8,	 -2449.72,	 918.54,	 57.2093,	 -182.0,	 0,	 4100,	 "SFHSS2",	 0,	 2,	 20, 6},
{-2447.62,	 820.771,	 34.256,	 -1.60131,		 1.0,	   	 2.0,	   	 8,	 -2447.62,	 818.149,	 34.256,	 -182.0,	 0,	 4100,	 "SFHSS1",	 0,	 2,	 20, 6},
{-2372.92,	 692.687,	 34.138,	 -3.10243,		 1.0,	   	 2.0,	   	 8,	 -2372.92,	 690.065,	 34.138,	 -182.0,	 0,	 4100,	 "SFHSS2",	 0,	 2,	 20, 6},
{-2338.61,	 579.323,	 27.0123,	 -1.57161,		 1.4,		 2.0,	   	 8,	 -2338.61,	 575.7,		 27.0123,	 -182.0,	 0,	 4100,	 "SFHSS1",	 0,	 2,	 20, 6},
{-2321.97,	 819.509,	 44.3052,	 -1.57161,		 1.4,		 3.0,	   	 8,	 -2321.97,	 815.887,	 44.3052,	 -182.0,	 0,	 4100,	 "SFHSS1",	 0,	 2,	 20, 6},
{-2401.5,	 869.344,	 43.3889,	 -0.000817418,	 1.4,		 3.0,	   	 8,	 -2397.5,	 868.722,	 43.0689,	 -94.0,		 0,	 4100,	 "SFHSM1",	 0,	 2,	 20, 6},
{-2401.48,	 930.783,	 44.4973,	 -0.000817418,	 1.4,		 3.0,	   	 8,	 -2397.48,	 930.161,	 44.4973,	 -94.0,		 0,	 4100,	 "SFHSS1",	 0,	 2,	 20, 6},
{-2569.1,	 795.796,	 48.9819,	 1.56998,		 3.4,		 5.0,	   	 8,	 -2569.1,	 801.174,	 48.9819,	 2.0,		 0,	 4100,	 "SFHSB3",	 0,	 2,	 20, 6},
{-2539.92,	 767.238,	 39.0419,	 -0.000817418,	 3.0,	   	 3.0,	   	 8,	 -2534.92,	 766.615,	 38.5919,	 270.0,		 0,	 4100,	 "SFHSB3",	 0,	 2,	 20, 6},
{-2684.77,	 819.657,	 49.0326,	 -0.000817418,	 2.0,	   	 2.0,	   	 8,	 -2684.77,	 817.657,	 49.0326,	 186.0,		 0,	 4100,	 "SFHSB1",	 0,	 2,	 20, 6},
{-2381.23,	 1281.01,	 22.1852,	 -0.000817418,	 3.0,	   	 3.0,	   	 8,	 -2378.23,	 1281.26,	 21.9852,	 269.0,		 0,	 4100,	 "SFHSS1",	 0,	 2,	 20, 6},
{-2279.5,	 1148.84,	 61.0751,	 -0.000817418,	 3.0,	   	 3.0,	   	 8,	 -2276.5,	 1148.84,	 60.5751,	 260.0,		 0,	 4100,	 "SFHSS1",	 0,	 2,	 20, 6},
{-2280.55,	 916.429,	 65.6849,	 -0.000817418,	 3.0,	   	 3.0,	   	 8,	 -2277.55,	 916.429,	 65.6849,	 260.0,		 0,	 4100,	 "SFHSS1",	 0,	 2,	 20, 6}
};

stock static const buildings_data[][ENUM_BUILDINGS_DATA] = {
	{0.0, 0.0, 0.0, 0.9, 0.9, 0.9, 0.9, 11, 1.1, 1.1, 1.1, 0.1, 0.1, 0.1, 0.1, 0}
};

stock static buildings_cached_pickups[MAX_CACHED_PICKUPS];
stock static buildings_player_enex_cooldowns[MAX_PLAYERS];

forward buildings_SetPlayerEnExCooldown(playerid);

stock buildings_OnGameModeInit(){
	DisableInteriorEnterExits();

	for(new i; i < sizeof(buildings_gta_enex); i++){
		/*
		 * creates two pickups and caches their pickup id to reference the current enex marker in buildings_gta_enex, entry and exit pickup respectively
		*/
		buildings_cached_pickups[CreatePickup(ENEX_MARKER_MODEL_ID, 1, buildings_gta_enex[i][X1], buildings_gta_enex[i][Y1], buildings_gta_enex[i][Z1], 0)] = i;
		buildings_cached_pickups[CreatePickup(ENEX_MARKER_MODEL_ID, 1, buildings_gta_enex[i][X2], buildings_gta_enex[i][Y2], buildings_gta_enex[i][Z2], i+1)] = i; //last argument is the pickup's virtual world, offset by 1;
	}
	return 1;
}

stock buildings_OnGameModeExit(){
	for(new i; i < sizeof(buildings_cached_pickups); i++){
		DestroyPickup(i);
	}
	return 1;
}

stock buildings_OnPlayerConnect(playerid){
	for(new i; i < sizeof(buildings_gta_enex); i++){
		SetPlayerMapIcon(playerid, i, buildings_gta_enex[i][X1], buildings_gta_enex[i][Y1], buildings_gta_enex[i][Z1], 37, 0, MAPICON_LOCAL);
	}
	return 1;
}

stock buildings_OnPlayerPickUpPickup(playerid, pickupid){
	/*
	 * due to the way enex markers are/will be scripted, players will be teleported immediately upon picking up the enex pickup
	 * buildings_player_enex_cooldowns is then used to store whether or not a player can be teleported again when inside an enex marker
	 * this prevents cases where a player will be continuously teleported while inside an enex marker
	*/
	buildings_player_enex_cooldowns[playerid] = true;
	SetTimerEx("buildings_SetPlayerEnExCooldown", ENEX_TELEPORT_COOLDOWN, false, "d", playerid);

	SetPlayerPos(playerid, buildings_gta_enex[buildings_cached_pickups[pickupid]][X2], buildings_gta_enex[buildings_cached_pickups[pickupid]][Y2], buildings_gta_enex[buildings_cached_pickups[pickupid]][Z2] + buildings_gta_enex[buildings_cached_pickups[pickupid]][I2]);
	SetPlayerFacingAngle(playerid, buildings_gta_enex[buildings_cached_pickups[pickupid]][ROT2]);
	SetCameraBehindPlayer(playerid);
	return 1;
}

public buildings_SetPlayerEnExCooldown(playerid){
	buildings_player_enex_cooldowns[playerid] = false;
}

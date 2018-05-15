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
	EXIT_TARGET_INTERIOR_ID,
	NAME[8]
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
/*
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
*/

/*
 * GTA SA ENEX DATA 
 * extracted from .ipl files
 * table best viewed with a tabwidth of 4
 * structure preserved to make importing new enexs easier
 * importing enexs should have proper int to float conversions to prevent tag mismatches
*/
/*
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
*/

stock static const buildings_data[][ENUM_BUILDINGS_DATA] = {
	{-1883.20000,	865.47300,	34.26010,	161.39100,	-95.28560,	1000.81000,	0.00000,	18,	161.39100,	-96.68560,	1000.81000,	-1886.20000,	862.47300,	34.26010,	129.00000,	0,	"CLOTHGP"},
	{-1808.69000,	945.86300,	23.86480,	372.35200,	-131.65100,	1000.45000,	-0.10001,	5,	372.35200,	-133.55100,	1000.45000,	-1805.79000,	943.22100,	23.91480,	3824.59000,	0,	"FDPIZA"},
	{-2099.68000,	897.48500,	75.96610,	-1.00000,	-1.00000,	-1.00000,	-1.00000,	-1,	-1.00000,	-1.00000,	-1.00000,	-2103.76000,	901.73400,	75.71610,	4374.68000,	0,	"SVSFBG"},
	{-2213.54000,	720.84500,	48.42620,	-1.00000,	-1.00000,	-1.00000,	-1.00000,	-1,	-1.00000,	-1.00000,	-1.00000,	-2214.06000,	725.03600,	48.42620,	36.00000,	0,	"SVSFSM"},
	{-1673.01000,	1337.93000,	6.18842,	-1.00000,	-1.00000,	-1.00000,	-1.00000,	-1,	-1.00000,	-1.00000,	-1.00000,	-1689.35000,	1335.56000,	16.00000,	-48.00000,	0,	"P69_ENT"},
	{-1690.75000,	1334.37000,	15.31800,	-1.00000,	-1.00000,	-1.00000,	-1.00000,	-1,	-1.00000,	-1.00000,	-1.00000,	-1675.09000,	1335.00000,	6.31796,	-222.00000,	0,	"P69_ENT"},
	{-1700.01000,	1380.49000,	6.20434,	459.35100,	-110.10500,	998.71800,	0.00000,	5,	459.35100,	-111.00500,	998.71800,	-1701.83000,	1378.97000,	6.20434,	3729.57000,	0,	"DINER2"},
	{-1721.13000,	1359.01000,	6.19634,	372.35200,	-131.65100,	1000.45000,	-0.10001,	5,	372.35200,	-133.55100,	1000.45000,	-1725.89000,	1359.34000,	6.19634,	96.00000,	0,	"FDPIZA"},
	{-1912.27000,	828.02500,	34.56150,	363.41300,	-74.57870,	1000.55000,	-45.30000,	10,	363.11300,	-74.87870,	1000.55000,	-1910.26000,	830.59800,	34.22150,	334.00000,	0,	"FDBURG"},
	{-1694.76000,	951.59900,	24.27060,	226.29400,	-7.43153,	1001.26000,	90.00000,	5,	227.29400,	-7.43153,	1001.26000,	-1699.27000,	950.59900,	24.27060,	92.00000,	0,	"CSDESGN"},
	{-1749.35000,	869.27900,	24.05930,	-1.00000,	-1.00000,	-1.00000,	-1.00000,	-1,	-1.00000,	-1.00000,	-1.00000,	-1753.85000,	885.67900,	295.05900,	-65.00000,	0,	""},
	{-1753.75000,	883.96500,	294.64500,	-1.00000,	-1.00000,	-1.00000,	-1.00000,	-1,	-1.00000,	-1.00000,	-1.00000,	-1749.38000,	865.15800,	24.14550,	4152.66000,	0,	""},
	{-1815.84000,	618.67800,	34.29890,	365.67300,	-10.71320,	1000.87000,	-0.10001,	9,	365.67300,	-11.61320,	1000.87000,	-1814.64000,	615.40200,	34.29890,	208.00000,	0,	"FDCHICK"},
	{-1887.43000,	749.59200,	44.46580,	441.98200,	-52.21990,	998.68900,	180.00000,	6,	441.98200,	-49.91990,	998.68900,	-1890.11000,	749.59200,	44.46580,	3691.82000,	0,	"REST2"},
	{-2270.46000,	-155.95700,	34.35730,	774.21400,	-48.92430,	999.68800,	0.00000,	6,	774.21400,	-50.02430,	999.68800,	-2269.46000,	-155.95700,	34.35730,	270.00000,	0,	"GYM2"},
	{-2625.85000,	208.34500,	3.98935,	286.14900,	-40.64440,	1000.57000,	-0.10001,	1,	286.14900,	-41.54440,	1000.57000,	-2625.85000,	209.14300,	3.98935,	5400.06000,	0,	"AMMUN1"},
	{-2671.53000,	258.34400,	3.64932,	365.67300,	-10.71320,	1000.87000,	-0.10001,	9,	365.67300,	-11.61320,	1000.87000,	-2671.53000,	259.14100,	3.64932,	5400.06000,	0,	"FDCHICK"},
	{-2454.44000,	-135.87900,	25.22230,	-1.00000,	-1.00000,	-1.00000,	-1.00000,	-1,	-1.00000,	-1.00000,	-1.00000,	-2455.44000,	-135.87900,	25.22230,	90.00000,	0,	"SVSFMD"},
	{-2425.94000,	337.87000,	35.99700,	-1.00000,	-1.00000,	-1.00000,	-1.00000,	-1,	-1.00000,	-1.00000,	-1.00000,	-2424.94000,	337.37000,	35.99700,	-118.00000,	0,	"SVHOT1"},
	{-2571.18000,	246.69800,	9.64213,	418.65300,	-82.63980,	1000.96000,	0.00000,	3,	418.65300,	-84.13980,	1000.96000,	-2570.18000,	245.49800,	9.34213,	-138.00000,	0,	"BARBER2"},
	{-2463.06000,	132.28700,	34.19800,	452.49000,	-18.17970,	1000.18000,	90.00000,	1,	452.89000,	-18.17970,	1000.18000,	-2462.06000,	133.28700,	34.19800,	5359.06000,	0,	"FDREST1"},
	{-2551.79000,	193.77800,	5.21905,	493.39100,	-22.72280,	999.68700,	0.00000,	17,	493.39100,	-24.92280,	999.68700,	-2553.79000,	193.77800,	5.21905,	105.00000,	0,	"BAR1"},
	{-2336.95000,	-166.64600,	34.35730,	363.41300,	-74.57870,	1000.55000,	-45.30000,	10,	363.11300,	-74.87870,	1000.55000,	-2335.95000,	-166.64600,	34.35730,	270.00000,	0,	"FDBURG"},
	{-2491.98000,	-29.10650,	24.81700,	203.77800,	-48.49240,	1000.80000,	0.00000,	1,	203.77800,	-49.89240,	1000.80000,	-2494.48000,	-29.10650,	24.81700,	90.00000,	0,	"LACS1"},
	{-2491.98000,	-38.95870,	24.81700,	-204.44000,	-8.46960,	1001.30000,	0.00000,	17,	-204.44000,	-9.16960,	1001.30000,	-2494.48000,	-38.95870,	24.81700,	90.00000,	0,	"TATTO2"},
	{-2027.73000,	-40.54880,	37.82630,	-1.00000,	-1.00000,	-1.00000,	-1.00000,	-1,	-1.00000,	-1.00000,	-1.00000,	-2027.83000,	-44.04540,	37.02630,	4139.70000,	0,	"SVSFBG"},
	{-2242.69000,	-88.25580,	34.35780,	501.98100,	-69.15020,	997.83500,	180.00000,	11,	501.98100,	-67.75020,	997.83500,	-2245.38000,	-88.25580,	34.35780,	3691.82000,	0,	"BAR2"},
	{-2700.32000,	820.30800,	48.99900,	-1.00000,	-1.00000,	-1.00000,	-1.00000,	-1,	-1.00000,	-1.00000,	-1.00000,	-2700.32000,	818.68600,	48.99900,	-180.00000,	0,	"SVSFSM"},
	{-2375.32000,	910.29300,	44.45780,	207.73800,	-109.02000,	1004.27000,	0.00000,	15,	207.73800,	-111.42000,	1004.27000,	-2377.32000,	909.29300,	44.45780,	5507.58000,	0,	"CSCHP"},
	{-2356.48000,	1008.01000,	49.90360,	363.41300,	-74.57870,	1000.55000,	-45.30000,	10,	363.11300,	-74.87870,	1000.55000,	-2356.48000,	1005.14000,	49.90360,	-180.00000,	0,	"FDBURG"},
	{-2524.11000,	1216.16000,	36.44960,	459.35100,	-110.10500,	998.71800,	0.00000,	5,	459.35100,	-111.00500,	998.71800,	-2521.86000,	1216.16000,	36.44960,	-90.00000,	0,	"DINER2"}
};

stock static buildings_cached_pickups[MAX_CACHED_PICKUPS];
stock static bool:buildings_player_enex_cooldowns[MAX_PLAYERS];

forward buildings_SetPlayerEnExCooldown(playerid);

stock buildings_OnGameModeInit(){
	DisableInteriorEnterExits();

	for(new i; i < sizeof(buildings_data); i++){
		/*
		 * creates two pickups and caches their pickup id to reference the current enex marker in buildings_data, entry and exit pickup respectively
		*/
		buildings_cached_pickups[CreatePickup(ENEX_MARKER_MODEL_ID, 1, buildings_data[i][ENTRY_PICKUP_X], buildings_data[i][ENTRY_PICKUP_Y], buildings_data[i][ENTRY_PICKUP_Z] + 2, 0)] = i;
		buildings_cached_pickups[CreatePickup(ENEX_MARKER_MODEL_ID, 1, buildings_data[i][EXIT_PICKUP_X], buildings_data[i][EXIT_PICKUP_Y], buildings_data[i][EXIT_PICKUP_Z] +2, i+1)] = i; //last argument is the pickup's virtual world, offset by 1;
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
	for(new i; i < sizeof(buildings_data); i++){
		SetPlayerMapIcon(playerid, i, buildings_data[i][ENTRY_PICKUP_X], buildings_data[i][ENTRY_PICKUP_Y], buildings_data[i][ENTRY_PICKUP_Z], 37, 0, MAPICON_LOCAL);
	}
	return 1;
}

stock buildings_OnPlayerPickUpPickup(playerid, pickupid){
	if(buildings_player_enex_cooldowns[playerid] == false){
		/*
		 * due to the way enex markers are/will be scripted, players will be teleported immediately upon picking up the enex pickup
		 * buildings_player_enex_cooldowns is then used to store whether or not a player can be teleported again when inside an enex marker
		 * this prevents cases where a player will be continuously teleported while inside an enex marker
		*/
		buildings_player_enex_cooldowns[playerid] = true;
		SetTimerEx("buildings_SetPlayerEnExCooldown", ENEX_TELEPORT_COOLDOWN, false, "d", playerid);

		if(GetPlayerVirtualWorld(playerid) == 0){
			SetPlayerPos(playerid, buildings_data[buildings_cached_pickups[pickupid]][ENTRY_TARGET_X], buildings_data[buildings_cached_pickups[pickupid]][ENTRY_TARGET_Y], buildings_data[buildings_cached_pickups[pickupid]][ENTRY_TARGET_Z] + 1.5);
			SetPlayerFacingAngle(playerid, buildings_data[buildings_cached_pickups[pickupid]][ENTRY_TARGET_FACING_ANGLE]);
			SetPlayerInterior(playerid, buildings_data[buildings_cached_pickups[pickupid]][ENTRY_TARGET_INTERIOR_ID]);
			SetPlayerVirtualWorld(playerid, buildings_cached_pickups[pickupid]++); //virtual world is equal to the index of the building + 1 since the default virtual world is 0, so building 0' virtual world is 1
		}
		else {
			SetPlayerPos(playerid, buildings_data[buildings_cached_pickups[pickupid]][EXIT_TARGET_X], buildings_data[buildings_cached_pickups[pickupid]][EXIT_TARGET_Y], buildings_data[buildings_cached_pickups[pickupid]][EXIT_TARGET_Z] + 1.5);
			SetPlayerFacingAngle(playerid, buildings_data[buildings_cached_pickups[pickupid]][EXIT_TARGET_FACING_ANGLE]);
			SetPlayerInterior(playerid, buildings_data[buildings_cached_pickups[pickupid]][EXIT_TARGET_INTERIOR_ID]);
			SetPlayerVirtualWorld(playerid, 0); 
		}
		SetCameraBehindPlayer(playerid);
	}
	return 1;
}

public buildings_SetPlayerEnExCooldown(playerid){
	buildings_player_enex_cooldowns[playerid] = false;
}

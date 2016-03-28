//
//  DTDatabaseQueries.h
//  DuoTrac
//
//  Created by PHAN P. Dong (Alain) on 11/10/15.
//  Copyright (c) 2015 Coach Labs. All rights reserved.
//

#ifndef DuoTrac_DTDatabaseQueries_h
#define DuoTrac_DTDatabaseQueries_h

/***** General Queries *****/

#define kDTQueryObjectByID @"SELECT * FROM %@ WHERE id = ?;"


/***** Registration *****/

/**
 *  Get all user IDs.
 */
#define kDTQueryAllUserIDs @"SELECT id from users ORDER BY id ASC;"

/**
 *  Get all users.
 */
#define kDTQueryAllUsers @"SELECT * from users ORDER BY created DESC;"

/**
 *  Get user by ID.
 */
#define kDTQueryUserByID @"SELECT * from users WHERE id = ?;"

/**
 *  Update existing user.
 */
#define kDTQueryUpdateUser @"UPDATE users SET name = ?, email = ?, height_inches = ?, height_feet = ?, weight = ?, gender = ?, age = ?, training_hours = ?, training_units = ?, modified = ? WHERE id = ?;"

/**
 *  Create new user.
 */
#define kDTQueryAddUser @"INSERT or REPLACE INTO users (id, name, email, height_inches, height_feet, weight, gender, age, training_hours, training_units) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);"

/**
 *  Delete an existing user.
 */

#define kDTQueryDeleteSwingsByUser @"DELETE FROM swings WHERE id in \
(SELECT swings.id FROM swings INNER JOIN sessions ON (swings.session_id = sessions.id) \
WHERE sessions.user_id = ?);"

#define kDTQueryDeleteSessionsByUser @"DELETE FROM sessions WHERE user_id = ?;"

#define kDTQueryDeleteUserByID @"DELETE from users WHERE id = ?;"

/***** Swing Navigation *****/

/**
 *  Get all sessions.
 */
#define kDTQuerySessionsByUserID @"SELECT sessions.*, count(swings.id) as swings \
FROM sessions LEFT OUTER JOIN swings ON (sessions.id = swings.session_id) \
WHERE sessions.user_id = ? \
GROUP BY sessions.id \
ORDER BY sessions.start_date ASC, sessions.session ASC;"

/**
 *  Get all swings by sessionID
 */
#define kDTQuerySwingsBySessionID @"SELECT * FROM swings WHERE session_id = ?;"


/***** Swing Attemp *****/

/**
 *  Get the last session number of the sessions in a definded date range.
 */
#define kDTQueryMaxSessionNumberInDates @"SELECT MAX(session) as session FROM sessions WHERE start_date >= ? AND start_date <= ?;"

/**
 *  Get the last session ID.
 */
#define kDTQueryLastSessionID @"SELECT MAX(id) as id FROM sessions;"

/**
 *  Add/update session
 */
#define kDTQueryAddSession @"INSERT or REPLACE INTO sessions (id, user_id, start_date, session) VALUES (?, ?, ?, ?);"

/**
 *  Add/update swing
 */
#define kDTQueryAddSwing @"INSERT INTO swings (session_id, swing, address_club, address_hip, impact_club, \
impact_hip, downswing_club, downswing_hip, top_club, top_hip) \
VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"

/**
 *  Get the last swing number of a session
 */
#define kDTQueryMaxSwingNumberOfSession @"SELECT MAX(swing) as swing FROM swings WHERE session_id = ?"

/**
 *  Get the last swing ID.
 */
#define kDTQueryLastSwingID @"SELECT MAX(id) as id FROM swings;"

#endif

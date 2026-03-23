// SPDX-License-Identifier: MIT
pragma solidity 0.8.31;

/// @title Imperial Astro-Chronicle
/// @notice Registry of cosmic events and user interpretations.
/// @dev Pure text-only contract. No funds, no owner, no external calls.

contract ImperialAstroChronicle {

    uint256 public constant MAX_TEXT_SIZE = 1000;

    struct Event {
        string name;            // Name of the cosmic event
        string description;     // What the event is
        string eventType;       // Astronomican, Warp-Star, Eclipse, Rift-Signal, Unknown
        uint256 importance;     // 1–5
        address recorder;       // Who recorded it
        uint256 timestamp;      // When it was created
    }

    struct Interpretation {
        uint256 eventId;        // Which event is being interpreted
        string text;            // Interpretation text
        address interpreter;    // Who interpreted it
        uint256 timestamp;      // When it was added
    }

    Event[] public events;
    Interpretation[] public interpretations;

    event EventRecorded(
        uint256 indexed eventId,
        string name,
        string eventType,
        uint256 importance,
        address indexed recorder
    );

    event InterpretationAdded(
        uint256 indexed interpretationId,
        uint256 indexed eventId,
        address indexed interpreter
    );

    /// @notice Record a new cosmic event.
    function recordEvent(
        string calldata name,
        string calldata description,
        string calldata eventType,
        uint256 importance
    ) external {
        require(bytes(name).length <= MAX_TEXT_SIZE, "Name too large");
        require(bytes(description).length <= MAX_TEXT_SIZE, "Description too large");
        require(bytes(eventType).length <= MAX_TEXT_SIZE, "Type too large");
        require(importance >= 1 && importance <= 5, "Importance must be 1-5");

        Event memory e = Event({
            name: name,
            description: description,
            eventType: eventType,
            importance: importance,
            recorder: msg.sender,
            timestamp: block.timestamp
        });

        events.push(e);
        uint256 id = events.length - 1;

        emit EventRecorded(id, name, eventType, importance, msg.sender);
    }

    /// @notice Add an interpretation to an existing event.
    function interpretEvent(
        uint256 eventId,
        string calldata text
    ) external {
        require(eventId < events.length, "Invalid event");
        require(bytes(text).length <= MAX_TEXT_SIZE, "Text too large");

        Interpretation memory i = Interpretation({
            eventId: eventId,
            text: text,
            interpreter: msg.sender,
            timestamp: block.timestamp
        });

        interpretations.push(i);
        uint256 id = interpretations.length - 1;

        emit InterpretationAdded(id, eventId, msg.sender);
    }

    /// @notice Total number of events.
    function totalEvents() external view returns (uint256) {
        return events.length;
    }

    /// @notice Total number of interpretations.
    function totalInterpretations() external view returns (uint256) {
        return interpretations.length;
    }
}

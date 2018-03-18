package ca.camosun.lab6converter;

// Interface for all conversion actions to conform to
// All conversion actions must convert an input Double to an output Double
public interface PerformsConversion {
    Double convert(Double value);
}
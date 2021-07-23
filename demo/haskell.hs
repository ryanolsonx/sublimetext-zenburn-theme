main :: IO ()
main = do
    input <- parseInput <$> readFile "input.txt"

    let sizes = [(size .(foldl1 intersection) . (map fromList) . words) line |
                     line <- input]

    print $ sum sizes
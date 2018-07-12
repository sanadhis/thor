import time #required for InstagramAPI
from InstagramAPI import InstagramAPI
import sys
import os

def processFollowers(API, userid):
    followers   = []
    next_max_id = True
    while next_max_id:
        if next_max_id == True: 
            next_max_id = ''
        _ = API.getUserFollowers(userid, maxid = next_max_id)
        followers.extend( API.LastJson.get('users',[]))
        next_max_id = API.LastJson.get('next_max_id','')

    your_followers = [dic['username'] for dic in followers]
    return your_followers

def processFollowing(API, userid):
    following   = []
    next_max_id = True
    while next_max_id:
        if next_max_id == True: 
            next_max_id=''
        _ = API.getUserFollowings(userid, maxid = next_max_id)
        following.extend ( API.LastJson.get('users',[]))
        next_max_id = API.LastJson.get('next_max_id','')

    you_follow = [dic['username'] for dic in following]
    return you_follow

def main():

    username = os.getenv("ig_username")
    password = os.getenv("ig_password")
    userid   = os.getenv("ig_userid")

    API = InstagramAPI(username, password)
    followers = []

    if username is None or password is None or userid is None:
        print("Please provide username and password in environment")
        sys.exit()
    elif not API.login():
        print("Wrong username and password")
        sys.exit()
    elif not API.getUsernameInfo(userid):
        print("User id does not exist")
        sys.exit() 
    else:
       followers = processFollowers(API, userid)
       following = processFollowing(API, userid)
       
       people_should_follow = [person for person in followers if person not in following]
       people_should_unfollow = [person for person in following if person not in followers]

    print("People you should follow:")
    for person in people_should_follow:
        print(person, end=' ')

    print("\n\nPeople you should unfollow:")
    for person in people_should_unfollow:
        print(person, end=' ')

if __name__ == "__main__":
    main()